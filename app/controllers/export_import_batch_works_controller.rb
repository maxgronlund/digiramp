class ExportImportBatchWorksController < ApplicationController
  include AccountsHelper
  before_action :access_account
  def show
    @import_batch = ImportBatch.find(params[:id])
    @recordings   = @import_batch.recordings
    
    
    works = []
    @recordings.each do |recording|
      works << recording.common_work
    end

    
    

    respond_to do |format|
      format.csv { render text: generate_cvs_file_from( works) }
    end
  end
  
  def generate_cvs_file_from works
    
    CSV.generate do |csv|
      csv << ['Account Id', 'Id', 'Title', 'Alternative Titles', 'Description', 'ISWC', 'Recording Id\'s' ]
      works.each do |common_work|
        recording_ids = ''
        common_work.recordings.each do |recording|
          recording_ids << recording.id.to_s
          recording_ids << ','
        end
        
        csv << [  common_work.account_id.to_s, 
                  common_work.id.to_s,
                  common_work.title, 
                  common_work.alternative_titles,
                  common_work.description.to_s.squish,
                  common_work.iswc_code,
                  recording_ids 
                
                ]
      end
    end
    
  end
end
