class CommonWorksImport < ActiveRecord::Base
  belongs_to :account
  belongs_to :catalog
  #attr_accessible :title, :body, :imported_works, :in_progress, :params, :processed_works, :total_works, :updated_works
  has_many :common_works
  
  attr_accessor :user_name, :password
  
  # clear memcache
  after_commit :flush_cache
  
  serialize :params, Array 
  
  PROS = ['ASCAP', 'BMI']
  
  
  def parse_common_works
    ap '--------------------------------------------------------------'
    ap 'CommonWorksImport#parse_common_works'
    ap self
    
    self.imported_works = 0
    
    self.params.each do |param|
      ap '---------------------------------- PARAMS -------------------------------------------'
      ap param
      ap '-------------------------------------------------------------------------------------'
      begin
        if alternate_ids =  params[:alternate_ids]
          iswc_code = alternate_ids["ISWC"]
        else
          iswc_code = nil
        end
      rescue
        iswc_code = nil
      end
      
      begin
        if common_work = CommonWork.find_by( 
          ascap_work_id:  param[:ascap_work_id].to_i,
          account_id:     self.account_id
        )
        else common_work = CommonWork.create( 
            ascap_work_id:          param[:ascap_work_id].to_i,
            account_id:             self.account_id,
            title:                  param[:title],
            iswc_code:              iswc_code,
            common_works_import_id: self.id
          )
          #iswc_code    = ( common_work[:alternate_ids] && common_work[:alternate_ids]["ISWC"]) ? common_work[:alternate_ids]["ISWC"] : nil
          
          #common_work.iswc_code               = param[:alternate_ids]["ISWC"]  if common_work[:alternate_ids] && common_work[:alternate_ids]["ISWC"]
          #common_work.submitter_work_id       = param[:alternate_ids]["Submitter Work ID"] if common_work[:alternate_ids] && common_work[:alternate_ids]["Submitter Work ID"]
          #common_work.common_works_import_id  = self.id
          #common_work.account_id              = self.account_id
        
         
          # parse details
          if details    = param[:details]
            common_work.update_columns(
              surveyed_work:      details["Surveyed Work"],
              last_distribution:  details["Last Distribution Yr/Qtr"],
              work_status:        details["Work Status"],
              work_type:          details["Work Type"],
              arrangement:        details["Arrangement of Public Domain Work"] != 'N'
            )
          end
        end
        
        # common_work_user
        CommonWorkUser.where(
          common_work_id:           common_work.id,
          user_id:                  account.user_id
        )
        .first_or_create(
          common_work_title:        param[:title],
          common_work_id:           common_work.id,
          user_id:                  account.user_id,
          can_manage_common_work:   true
        )
        # parse ipis
        parse_ipis common_work.id, param[:ipis]
        
        
        # set health
        common_work.update_completeness
        
        # update import count
        self.imported_works += 1
        
        # add to catalog
        add_to_catalog common_work, self.catalog_id

      rescue => e
        ap '==================================================================='
        ap 'ERROR'
        ap e.inspect
        
        ErrorNotification.post_object "CommonWorksImport#parse_common_works", e
      end
    end
    # not in progress any more
    self.in_progress = false
    self.save!
    
    channel = 'digiramp_radio_' + user_email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'Success', 
                                          "message" => "#{self.imported_works} Common Works imported", 
                                          "time"    => '5000', 
                                          "sticky"  => 'true', 
                                          "image"   => 'success'
                                          })
    
  end
  
  def add_to_catalog common_work, catalog_id

    if catalog_id 

      CatalogsCommonWorks.where(
        catalog_id: catalog_id, 
        common_work_id: common_work.id
      )
      .first_or_create(
        catalog_id: catalog_id, 
        common_work_id: common_work.id
      )
                         

    else
      ErrorNotification.post "CommonWorksImport#add_to_catalog: ERROR: Unable to add common work to catalog"
    end
    
    
      
  end
  
  def parse_ipis common_work_id, ipis

    ipis.each do |ipi_scrape|
      if ipi = Ipi.find_by(
          ipi_code: ipi_scrape[:ipi_number] 
        )
      else 
        pro_affiliation = ProAffiliation.where(
          title: ipi_scrape[:society]
          )
          .first_or_create(
            title:  ipi_scrape[:society]
          )
        
        ipi = Ipi.create( 
            title:              ipi_scrape[:society],
            ipi_code:           ipi_scrape[:ipi_number],
            full_name:          ipi_scrape[:full_name],
            uuid:               UUIDTools::UUID.timestamp_create().to_s, 
            pro_affiliation_id: pro_affiliation.id  
          )            
      end
      
      ap '---------- IPI --------------------'
      ap ipi
      
      if CommonWorkIpi.find_by(
          common_work_id: common_work_id,
          ipi_id:         ipi.id
        )
      else
        common_work_ipi = CommonWorkIpi.new(
          common_work_id: common_work_id,
          ipi_id:         ipi.id,
          share:          ipi_scrape[:own_percent],
          full_name:      ipi_scrape[:full_name],
          uuid:           UUIDTools::UUID.timestamp_create().to_s, 
        )
        common_work_ipi.save(validate: false)
      end
      #ipi.full_name                = ipi_scrape[:full_name]
      #ipi.role                      = ipi_scrape[:role]
      #ipi.pro_affiliation_id        = pro_affiliation.id
      #ipi.perf_owned                = ipi_scrape[:own_percent]
      #ipi.perf_collected            = ipi_scrape[:collect_percent]
      #ipi.has_agreement             = ipi_scrape[:has_agreement]
      #ipi.linked_to_ascap_member    = ipi_scrape[:linked_to_ascap_member]
      #ipi.controlled_by_submitter   = ipi_scrape[:controlled_by_submitter]
      #ipi.ascap_work_id             = ascap_work_id
      

    end
    
  end
  
  
  def self.post_bmi_info user_email, work
    
    channel = 'digiramp_radio_' + user_email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'Info', 
                                          "message" => "Importing From BMI", 
                                          "time"    => '5000', 
                                          "sticky"  => 'false', 
                                          "image"   => 'progress'
                                          })
                                        
  end
  
  # parse ipi informations from BMI
  def parse_bmi_ipis common_work_id, role, info, bmi_work_id
    
    ipi = Ipi.where(common_work_id: common_work_id, 
                    ipi_code: info[:ipi_number] )
             .first_or_create( common_work_id: common_work_id, 
                               ipi_code: info[:ipi_number] )
    
    ipi.full_name                = info[:name]
    ipi.role                      = role
    ipi.pro                       = info[:society]
    ipi.perf_collected            = info[:share]
    ipi.bmi_work_id               = bmi_work_id
    #ipi.perf_owned                = ipi_scrape[:own_percent]
    #ipi.perf_collected            = ipi_scrape[:collect_percent]
    #ipi.has_agreement             = ipi_scrape[:has_agreement]
    #ipi.linked_to_ascap_member    = ipi_scrape[:linked_to_ascap_member]
    #ipi.controlled_by_submitter   = ipi_scrape[:controlled_by_submitter]
    #ipi.ascap_work_id             = ascap_work_id
    ipi.save!

  end
  
  def parse_works_from_bmi 

    
    imports = 0
    self.params.each do |catalog|
      work        = catalog[:work]
   
      # find or create the common work
      common_work = CommonWork.where( bmi_work_id:  work[:bmi_work_id],
                                      account_id:   self.account_id)
                              .first_or_create( bmi_work_id:  work[:bmi_work_id],
                                                account_id:   self.account_id)
      

      common_work.common_works_import_id    = self.id
      #common_work.bmi_catalog               = catalog[:catalog]
      common_work.iswc_code                 = work[:iswc]
      common_work.title                     = work[:title]
      common_work.registration_date         = work[:registration_date]   
      common_work.registration_origin       = work[:registration_origin] 
      common_work.update_completeness
      
      
      add_to_catalog common_work, self.catalog_id
      
      # parse writers
      if work[:writers]
        work[:writers].each do |writer|
          parse_bmi_ipis common_work.id, 'Writer', writer, work[:bmi_work_id]
        end 
      end
      
      # parse publishers
      if work[:publishers]
        work[:publishers].each do |publisher|
          parse_bmi_ipis common_work.id, 'Publisher', publisher, work[:bmi_work_id]
        end 
      end
      imports     += 1
    end
    # not in progress any more
    self.in_progress    = false
    self.imported_works = imports
    self.save!
    channel = 'digiramp_radio_' + user_email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'Success', 
                                          "message" => "#{self.imported_works} Common Works Imported", 
                                          "time"    => '5000', 
                                          "sticky"  => 'true', 
                                          "image"   => 'success'
                                          })
                                          
                                          
  end
  
  def self.post_info user_email, info
    
    channel = 'digiramp_radio_' + user_email
    if info[:error]
      ap "CommonWorksImport#post_info #{info}"
      
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Error', 
                                            "message" => 'Unable to log in', 
                                            "time"    => '500', 
                                            "sticky"  => 'true', 
                                            "image"   => 'error'
                                            })
      
    elsif info[:stage_complete] == :login
      
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Info', 
                                            "message" => 'Password Accepted', 
                                            "time"    => '4000', 
                                            "sticky"  => 'false', 
                                            "image"   => 'progress'
                                            })
    elsif info[:start] == :ascap_import
      
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Info', 
                                            "message" => 'ASCAP Import Started', 
                                            "time"    => '1000', 
                                            "sticky"  => 'false', 
                                            "image"   => 'notice'
                                            })
    elsif info[:start] == :bmi_import

      
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Info', 
                                            "message" => 'BMI Import Started', 
                                            "time"    => '4000', 
                                            "sticky"  => 'false', 
                                            "image"   => 'notice'
                                            })
    elsif info[:html_work_detail_tbodies]
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'Info', 
                                            "message" => 'Work imported', 
                                            "time"    => '4000', 
                                            "sticky"  => 'false', 
                                            "image"   => 'notice'
                                            })
    end

  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end


end

