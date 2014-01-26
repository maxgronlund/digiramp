require_relative 'datatable'

class AccountRecordingsDatatable < Datatable
  Columns = %w[
    recording.title
    recording.instrumental
    recording.clearance
    recording.explicit
  ]
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Recording.count,
      iTotalDisplayRecords: recordings.total_count,
      aaData: data
    }
  end

  private
  
  def data
    recordings.map do |recording|
      {
        checkbox:       @controller.render_to_string(partial:   'recordings/datatable/td_checkbox',         locals: {recording: recording}),
        title:          @controller.render_to_string(partial:   'recordings/datatable/td_title',            locals: {recording: recording}),
        instrumental:   @controller.render_to_string(partial:   'recordings/datatable/td_instrumental',     locals: {recording: recording}),
        clearance:      @controller.render_to_string(partial:   'recordings/datatable/td_clearance',        locals: {recording: recording}),
        explicit:       @controller.render_to_string(partial:   'recordings/datatable/td_explicit',         locals: {recording: recording}),
        admin:          @controller.render_to_string(partial:   'recordings/datatable/td_admin',            locals: {recording: recording, account: @controller.send(:current_user).account})
        
      }      
    end
  end
  
  def recordings
    return @recordings if @recordings
    @account = Account.find(params[:account_id])
    @recordings = @account.recordings.where(*search_query)
    #@recordings = @recordings.(title) unless sort_column.to_s.contains_nothing?
    @recordings = @recordings.page(page).per(per_page)
  end
  
  def search_query
    if params[:sSearch].present?
      queries =["recordings.title ilike :search"]
      [queries.join(" or "), search: "%#{params[:sSearch]}%"]
    else
      [""]
    end
  end
  
  def order
    "lower(#{sort_column}) #{sort_direction} NULLS LAST"
  end
end