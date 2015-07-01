class StakeholdersService
  
  
  def self.assign_recording_stakes master_split, recording_id, representative_id
    ap '------------ assign_recording_stakes -------------'
    return 0 unless recording       = Recording.cached_find(recording_id)
    return 1 unless representative  = User.cached_find(representative_id) 
    return 2 unless common_work     = recording.common_work
    
    digiramp_split       = 0.2
    representative_split = 0.2
    
    work_split           = 1.0 - master_split

    # take away digiramps part
    digiramp_part         =  1.0 * digiramp_split
    
    # take away the rep's part
    representatives_part  =  (1.0 - digiramp_split) * representative_split
    
    # the remaining
    work_and_master_part  =  ( 1.0 - representatives_part - digiramp_part )

    
    
    update_stake(  recording, digiramp_part,        nil, User.system_user )
    update_stake(  recording, representatives_part, nil, representative )
  
    masters_split(   recording,   work_and_master_part * master_split)
    copyright_split( common_work, work_and_master_part * work_split)
    
   
    # test
    #if Rails.env.development?
    #  total = 0.0
    #  Stake.find_each do |stake|
    #    ap stake
    #    total += stake.split_in_percent
    #  end
    #  ap '------------------------------'
    #  ap total
    #  ap '------------------------------'
    #  Stake.destroy_all
    #end
  end
  
  private

  # master part
  def self.masters_split( recording, split)
    
    recording.recording_ipis.each do |ipi|
      update_stake( recording, ipi.share * split * 0.01, ipi, ipi.user )
    end
  end

  def self.copyright_split( common_work, split)
    ap 'copyright_parts'
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
      # if the ip has been assigned a user
      remove_system_user( asset, ipi )
    end
    
    stake = Stake.where(   user_id:            user.id, 
                           account_id:         user.account.id,
                           asset_id:           asset.id,
                           asset_type:         asset.class.name,
                           ipiable_id:         ipi_id,
                           ipiable_type:       ipi_type
                         )
          .first_or_create(   user_id:            user.id, 
                              account_id:         user.account.id,
                              asset_id:           asset.id,
                              asset_type:         asset.class.name,
                              ipiable_id:         ipi_id,
                              ipiable_type:       ipi_type
                           )
    
    stake.currency                  = 'usd'
    stake.split_in_percent          = split
    stake.flat_rate_in_cent         = 0
    stake.email_for_missing_user    = ipi && ipi.user.nil? ? ipi.email : nil
    stake.unassigned                = ipi && ipi.user.nil? ? true      : false
    stake.save!

  end
  
  # if the system user temporarely was assigned to the ip and asset
  # then remove it
  def self.remove_system_user asset, ipi
    
    if stake = Stake.where( asset_id:       asset.id,
                            asset_type:     asset.class.name,
                            user_id:        User.system_user.id,
                            account_id:     User.system_user.account.id,
                            ipiable_id:     ipi.id,
                            ipiable_type:   ipi.class.name
                           )
       ap stake
     end
  end

end


#StakeholdersService.assign_recording_stakes( 1355, 1 )