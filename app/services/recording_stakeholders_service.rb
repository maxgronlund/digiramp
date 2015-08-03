# RecordingStakeholdersService.assign_recording_stakes(recording_id: self.id,  account_id: self.account.id )


class RecordingStakeholdersService
  
  # assign the rep stakes to the account's user
  def self.assign_recording_stakes options = {}
    
    return 0 unless account         = Account.cached_find(options[:account_id])
    return 1 unless recording       = Recording.cached_find(options[:recording_id])
    return 2 unless representative  = account.user 
    return 3 unless common_work     = recording.get_common_work
    digiramp_split                  = 0.2
    representative_split            = 0.2
    
    # what the ips on the master should share( typical 50/50)
    master_split                    = 0.5
    # what the ips on the work should share( typical 50/50)
    work_split                      = 1.0 - master_split

    # take away digiramps part
    digiramp_part                   =  1.0 * digiramp_split
    
    # take away the rep's part
    representatives_part            =  (1.0 - digiramp_split) * representative_split
    
    # the remaining to share between the master and the copyright
    work_and_master_part            =  ( 1.0 - representatives_part - digiramp_part )

    # digiramp and the rep is not IP's so the ipi parameter is nil
    update_stake(  recording, digiramp_part,        nil, User.system_user )
    update_stake(  recording, representatives_part, nil, representative )
    
    # hence there can be many IP's for the master and the copyright
    # it's layed out in functions
    masters_split(   recording,   work_and_master_part * master_split)
    copyright_split( common_work, work_and_master_part * work_split)
    
   
    # test
    #if Rails.env.development?
    #  total = 0.0
    #  recording.stakes.each do |stake|
    #    #stake
    #    total += stake.split_in_percent
    #  end
    #end
  end
  
  
  private
  

  # make the split for the master owners
  def self.masters_split( recording, split )
    recording.recording_ipis.each do |ipi|
      update_stake( recording, ipi.share * split * 0.01, ipi, ipi.user )
    end
  end

  # make the split for the copyright owners
  def self.copyright_split( common_work, split)
    common_work.ipis.each do |ipi|
      update_stake(  common_work, ipi.share * split * 0.01, ipi, ipi.user )
    end
  end

  def self.update_stake  asset, split, ipi , user
    # rep and system are not tied to an ip
    ipi_id      = ipi ? ipi.id         : nil
    ipi_type    = ipi ? ipi.class.name : nil
    
    # if there is a ip without an user
    if ipi && ipi.user.nil?
      # assign the system user untill user sign up
      user  = User.system_user 
    elsif ipi && ipi.user
      # remove the system user assigned above
      # if the ip user has sigened up since last
      remove_system_user( asset, ipi )
    end
    
    stake = Stake.where(   account_id:         user.account.id,
                           asset_id:           asset.id,
                           asset_type:         asset.class.name
                         )
          .first_or_create(   account_id:      user.account.id,
                              asset_id:        asset.id,
                              asset_type:      asset.class.name
                           )
    
    # update informations of importance
    stake.currency                  = 'usd'
    stake.split                     = split
    stake.flat_rate_in_cent         = 0
    stake.email    = ipi && ipi.user.nil? ? ipi.email : nil
    stake.unassigned                = ipi && ipi.user.nil? ? true      : false
    stake.save!

  end
  
  # find and remove the system user that temporarely was assigned 
  # to the ip and the asset
  def self.remove_system_user asset, ipi
    
    if stake = Stake.where( asset_id:       asset.id,
                            asset_type:     asset.class.name,
                            user_id:        User.system_user.id,
                            account_id:     User.system_user.account.id
                            #ipiable_id:     ipi.id,
                            #ipiable_type:   ipi.class.name
                           )
       
     end
  end

end

# StakeholdersService.assign_recording_stakes( recording_id: 1355,  account_id: 6  )





