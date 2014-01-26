require_relative 'datatable'

class AccountCommonWorksDatatable < Datatable
  Columns = %w[
    common_works.title
    common_works.alternative_titles
    common_works.iswc_code
    common_works.description
  ]
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: CommonWork.count,
      iTotalDisplayRecords: common_works.total_count,
      aaData: data
    }
  end

  private
  
  def data
    common_works.map do |common_work|
      {
        title:                    @controller.render_to_string(partial: 'common_works/td_title',                  locals: {common_work: common_work }),
        alternative_titles:       @controller.render_to_string(partial: 'common_works/td_alternative_titles',     locals: {common_work: common_work }),
        iswc_code:                @controller.render_to_string(partial: 'common_works/td_iswc_code',              locals: {common_work: common_work }),
        description:              @controller.render_to_string(partial: 'common_works/td_description',            locals: {common_work: common_work }),
        admin:                    @controller.render_to_string(partial: 'common_works/td_admin',                  locals: {common_work: common_work, account: @controller.send(:current_user).account})
      }      
    end
  end
  
  def common_works
    return @common_works if @common_works
    @account  = Account.find(params[:account_id])
    @common_works = @account.common_works.where(*search_query)
    @common_works = @common_works.order(order) unless sort_column.to_s.contains_nothing?
    @common_works = @common_works.page(page).per(per_page)
  end
  
  def search_query
    if params[:sSearch].present?
      queries =["common_works.title ilike :search",
                "common_works.alternative_titles ilike :search",
                "common_works.iswc_code ilike :search",
                "common_works.description ilike :search"]
      [queries.join(" or "), search: "%#{params[:sSearch]}%"]
    else
      [""]
    end
  end
  
  def order
    "lower(#{sort_column}) #{sort_direction} NULLS LAST"
  end
end