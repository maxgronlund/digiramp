require_relative 'datatable'

class AdminAccountsDatatable < Datatable
  Columns = %w[
    accounts.title
    accounts.account_type
    accounts.expiration_date
    accounts.users_count
  ]
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Account.count,
      iTotalDisplayRecords: accounts.total_count,
      aaData: data
    }
  end

  private
  
  def data
    accounts.map do |account|
      {
        company:      @controller.render_to_string(partial: 'admin/accounts/td_company',      locals: {account: account}),
        account_type: @controller.render_to_string(partial: 'admin/accounts/td_account_type', locals: {account: account}),
        expires:      @controller.render_to_string(partial: 'admin/accounts/td_expires',      locals: {account: account}),
        users:        @controller.render_to_string(partial: 'admin/accounts/td_users',        locals: {account: account}),
        admin:        @controller.render_to_string(partial: 'admin/accounts/td_admin',        locals: {account: account})
      }      
    end
  end
  
  def accounts
    return @accounts if @accounts
    @accounts = Account.where(*search_query)
    @accounts = @accounts.order(order) unless sort_column.to_s.contains_nothing?
    @accounts = @accounts.page(page).per(per_page)
  end
  
  def search_query
    if params[:sSearch].present?
      ["accounts.title ilike :search or accounts.account_type ilike :search", search: "%#{params[:sSearch]}%"]
    else
      [""]
    end
  end
  
  def order
    "lower(#{sort_column}) #{sort_direction} NULLS LAST"
  end
end