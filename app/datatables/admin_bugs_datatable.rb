require_relative 'datatable'

class AdminBugsDatatable < Datatable
  Columns = %w[
    bugs.title
    bugs.id
    bugs.user_id
    bugs.assigned_to
    bugs.status
    bugs.priority
  ]
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Bug.count,
      iTotalDisplayRecords: bugs.total_count,
      aaData: data
    }
  end

  private
  
  def data
    bugs.map do |bug|
      {
        title:        @controller.render_to_string(partial: 'admin/bugs/td_title',        locals: { bug: bug } ),
        id:           @controller.render_to_string(partial: 'admin/bugs/td_id',           locals: { bug: bug } ),
        user_id:      @controller.render_to_string(partial: 'admin/bugs/td_user_id',      locals: { bug: bug } ),
        assigned_to:  @controller.render_to_string(partial: 'admin/bugs/td_assigned_to',  locals: { bug: bug } ),
        status:       @controller.render_to_string(partial: 'admin/bugs/td_status',       locals: { bug: bug } ),
        priority:     @controller.render_to_string(partial: 'admin/bugs/td_priority',     locals: { bug: bug } ),
        manage:       @controller.render_to_string(partial: 'admin/bugs/td_manage',       locals: { bug: bug } )
      }
    end
  end
  
  def bugs
    return @bugs if @bugs
    @bugs = Bug.where(*search_query)
    @bugs = @bugs.order(order) unless sort_column.to_s.contains_nothing?
    @bugs = @bugs.page(page).per(per_page)
  end
  
  def search_query
    if params[:sSearch].present?
      queries =["bugs.title ilike :search",
                "bugs.body ilike :search",
                "bugs.status ilike :search",
                "bugs.priority ilike :search"]
      [queries.join(" or "), search: "%#{params[:sSearch]}%"]
    else
      [""]
    end
  end
  
  def order
    "lower(#{sort_column}) #{sort_direction} NULLS LAST"
  end
end