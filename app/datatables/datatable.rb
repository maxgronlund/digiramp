class Datatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  
  def h *a
    @view.send :h, *a
  end
  
  def initialize view, controller=nil, account=nil
    @view = view
    @controller = controller
    @account = account
  end
  
  
  private
  
  
  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 50
  end

  def sort_column
    sort_column = nil
    
    if client_column = params[:sColumns].to_s.split(',')[params[:iSortCol_0].to_i]
      self.class.const_get('Columns').each do |column|
        if column.split('.').last == client_column
          sort_column = column
        end
      end
    end
    
    sort_column.kind_of?(Array) ? sort_column.first : sort_column
    sort_column ||= self.class.const_get('Columns')[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end