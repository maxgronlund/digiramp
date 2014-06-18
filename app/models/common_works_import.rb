class CommonWorksImport < ActiveRecord::Base
  belongs_to :account
  #attr_accessible :title, :body, :imported_works, :in_progress, :params, :processed_works, :total_works, :updated_works
  has_many :common_works
  
  attr_accessor :user_name, :password
  
  serialize :params, Array 
  
  PROS = ['ASCAP', 'BMI']
  
  
  def parse_common_works
    ap self
    self.imported_works = 0
    self.params.each do |param|
      
      begin
        common_work = CommonWork.where( ascap_work_id:  param[:ascap_work_id].to_i,
                                        account_id:     self.account_id
                                      )
                                .first_or_create( ascap_work_id:  param[:ascap_work_id].to_i,
                                                  account_id:     self.account_id
                                                )
        
        common_work.title                   = param[:title]
        common_work.iswc_code               = param[:alternate_ids]["ISWC"]              if common_work[:alternate_ids] && common_work[:alternate_ids]["ISWC"]
        common_work.submitter_work_id       = param[:alternate_ids]["Submitter Work ID"] if common_work[:alternate_ids] && common_work[:alternate_ids]["Submitter Work ID"]
        common_work.common_works_import_id  = self.id
        common_work.account_id              = self.account_id
        
         
        # parse details
        if details    = param[:details]
          common_work.surveyed_work                         = details["Surveyed Work"]
          common_worklast_distribution                      = details["Last Distribution Yr/Qtr"]
          common_work.work_status                           = details["Work Status"]
          common_work.ascap_award_winner                    = details["ASCAP Award Winner"]
          
          # add to genre 
          if common_work.genre.to_s == ''
            # there is no genre so add it
            common_work.genre   = details["Genre"]
          elsif common_work.genre.include? details["Genre"]
            # do nothing genre is alreaddy added
          else
            # add as comma seperated list
            common_work.genre   += ','
            common_work.genre   += details["Genre"]
          end
          common_work.work_type                             = details["Work Type"]
          common_work.composite_type                        = details["Composite Type"]
          common_work.arrangement_of_public_domain_work     = details["Arrangement of Public Domain Work"]
        end
          
        # save
        common_work.save!
        
        # parse ipis
        parse_ipis common_work.id, param[:ipis]
        
        
        # set health
        common_work.update_completeness
        
        # update import count
        self.imported_works += 1
        
        # add to catalog
        common_work.add_to_catalog self.catalog_id

      rescue
        puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
        puts 'ERROR: Unable to parse ascap common work:' 
        puts 'In CommonWorksImport#parse_common_works'
        ap params
        puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      end
    end
    # not in progress
    self.in_progress = false
    self.save!
    
  end
  
  def parse_ipis common_work_id, ipis
    ipis.each do |ipi_scrape|
      ipi = Ipi.where(common_work_id: common_work_id, ipi_code: ipi_scrape[:ipi_number] )
               .first_or_create( common_work_id:  common_work_id, 
                                 ipi_code:        ipi_scrape[:ipi_number]
                                )
      ipi.pro                      = ipi_scrape[:society]
      ipi.perf_owned               = ipi_scrape[:own_percent]
      ipi.perf_collected           = ipi_scrape[:collect_percent]
      ipi.has_agreement            = ipi_scrape[:has_agreement]
      ipi.linked_to_ascap_member   = ipi_scrape[:linked_to_ascap_member]
      ipi.controlled_by_submitter  = ipi_scrape[:controlled_by_submitter]
      ipi.save!
    end
    
  end

end

