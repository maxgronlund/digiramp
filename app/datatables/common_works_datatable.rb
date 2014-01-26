require_relative 'datatable'

class CommonWorksDatatable < Datatable
  Columns = %w[common_works.title
               common_works.alternative_titles
               common_works.iswc_code]
  
  def as_json(options = {})
    ## We need to check if the user is admin !!!
    ## Should probably be done in the Api::CommonWorksController
    @common_work_model = @account.common_works# rescue CommonWork
    
    
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @common_work_model.count,
      iTotalDisplayRecords: common_works.total_count,
      aaData: data
    }
  end

  private
  
  def data
    common_works.map do |common_work|
      [
        link_to(common_work.title, "common_works/#{common_work.id}"),
        h(common_work.alternative_titles),
        h(common_work.iswc_code),
        h(common_work.created_at)
      ]
    end
  end
  
  def common_works
    @common_works ||= fetch_common_works
  end
  
  def fetch_common_works
    order = "NULLIF(lower(#{sort_column}), '') #{sort_direction} NULLS LAST"
    
    common_works = @common_work_model.select("common_works.*, NULLIF(lower(#{sort_column}), '')").order(order)
    common_works = common_works.page(page).per(per_page)
    
    if params[:sSearch].present?
      search common_works, params[:sSearch]
      return merge_relations @search_results if @search_results.length > 0
    end
    
    return common_works.uniq
  end
  
  def search _common_works, search_string
    @search_string = search_string
    @search_results = []
    search_by_instrumental _common_works
    search_by_text _common_works
  end
  
  def search_by_text _common_works
    search_query = [
      "common_works.title ilike :search",
      "common_works.alternative_titles ilike :search",
      "common_works.iswc_code = :raw"
    ].join(' or ')
        
    @search_string.split(' ').each do |word|
      add_search_result _common_works.where(search_query, search: "%#{word}%", raw: word)
    end
  end
  
  def search_by_instrumental _common_works
    #puts "search_by_instrumental"
    #search_not_instrumental_recordings _common_works
    #search_instrumental_recordings _common_works
    #puts "search_by_instrumental done"
  end
  
  def search_not_instrumental_recordings _common_works
    if match = @search_string.match(/((?<!\S)(not|no|non|minus|exclude(s?)|\-)((\s*)|\-)(instrumental(s?)))|vocal/i)
      @search_string.gsub!(match.to_s, '')
      @search_string.strip!
      add_search_result _common_works.where("recordings.instrumental IS FALSE")
    end
  end
  
  def search_instrumental_recordings _common_works
    if match = @search_string.match(/(?<!\S)(plus|include(s?)|only|(\s*)|\+)instrumental(s?)/i)
      @search_string.gsub!(match.to_s, '')
      add_search_result _common_works.where("recordings.instrumental IS TRUE")
    end
  end
    
  def add_search_result search_result
    @search_results << search_result #if search_result.length > 0
  end
  
  def merge_relations relations
    relation = relations.pop
    relations.each do |extra_relation|
      relation = relation.merge extra_relation
    end
    relation.uniq
  end
end