class User::ExportWorkAndMastersController < ApplicationController
  def show
    @common_works   = CommonWork.cached_find(params[:id])

    respond_to do |format|
      format.html
      #format.csv { render text: @common_works.to_csv }
      format.csv { 
        send_data(
          @common_works.to_csv,  
          disposition: "attachment; filename=#{@common_works.title.gsub(' ', '-')}-#{ DateTime.now.to_date}.csv",
          type: 'text/csv',
          stream: 'true', 
          buffer_size: '4096' 
        )
      }
    end

  end
end
