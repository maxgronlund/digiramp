require_relative 'datatable'

class AdminUsersDatatable < Datatable
  Columns = %w[
    users.name
    users.email
  ]
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: User.count,
      iTotalDisplayRecords: users.total_count,
      aaData: data
    }
  end

  private
  
  def data
    users.map do |user|
      {
        name:         @controller.render_to_string(partial: 'admin/users/td_name',         locals: {user: user}),
        email:        @controller.render_to_string(partial: 'admin/users/td_email',        locals: {user: user}),
        admin:        @controller.render_to_string(partial: 'admin/users/td_admin',        locals: {user: user})
      }      
    end
  end
  
  def users
    return @users if @users
    @users = User.where(*search_query)
    @users = @users.order(order) unless sort_column.to_s.contains_nothing?
    @users = @users.page(page).per(per_page)
  end
  
  def search_query
    if params[:sSearch].present?
      queries =["users.name ilike :search",
                "users.email ilike :search"]
      [queries.join(" or "), search: "%#{params[:sSearch]}%"]
    else
      [""]
    end
  end
  
  def order
    "lower(#{sort_column}) #{sort_direction} NULLS LAST"
  end
end