class RecordingsSearch  
  def initialize user_id, account_id=nil
    if account_id
      @result = Recording.select("id, *").where(account_id: account_id)
    else
      @account_users = AccountUser.where(user_id: user_id)
      account_user_queries = []
      @account_users.each do |account_user|
        account_user_queries << "\n account_id = #{account_user.account_id}"
      end
      @result = Recording.select("id, *").where(account_user_queries.join(' OR '))
    end
  end
  
  def isrc_code isrc_code
    isrc_code_pattern = sanitize("%#{isrc_code.strip}%")
    @result = @result.where("recordings.isrc_code ilike :isrc_code_pattern", isrc_code_pattern: isrc_code_pattern)
    self
  end
  def release_date  range            ;@result = @result.where release_date: range             ;self  end
  def bpm           range_or_numeric ;@result = @result.where bpm:          range_or_numeric  ;self  end
  def duration      range_or_numeric ;@result = @result.where duration:     range_or_numeric  ;self  end
  def clearance     has_clearance    ;@result = @result.where clearance:    has_clearance     ;self  end
  def explicit      is_explicit      ;@result = @result.where explicit:     is_explicit       ;self  end
  def instrumental  is_instrumental  ;@result = @result.where instrumental: is_instrumental   ;self  end
  
  ### Tags ############
  
  def genres genres
    @genres = genres
    self
  end
  
  def moods moods
    @moods = moods
    self
  end
  
  def instruments instruments
    @instruments = instruments
    self
  end
  
  ### Text ############
  
  def text query, order_direction='DESC'
    @basic_text = true
    raise ArgumentError, "RecordingsSearch text query cannot contain nothing." if query.to_s.contains_nothing?
    @result = @result.
      select(text_selection query).
      where(text_match_query, title: query, description: query, lyrics: query).
      order("#{text_rank query} #{order_direction}")
    self
  end
  
  def title_text query
    @title_text_query = query
    self
  end
  
  def description_text query
    @description_text_query = query
    self
  end
  
  def lyrics_text query
    @lyrics_text_query = query
    self
  end
  
  def result
    @ranks = []
    @ranks.push title_text_rank       @title_text_query       if @title_text_query
    @ranks.push description_text_rank @description_text_query if @description_text_query
    @ranks.push lyrics_text_rank      @lyrics_text_query      if @lyrics_text_query
    @order = @ranks.join(" +\n")
    
    @result = @result.select title_text_selection       @title_text_query       if @title_text_query
    @result = @result.select description_text_selection @description_text_query if @description_text_query
    @result = @result.select lyrics_text_selection      @lyrics_text_query      if @lyrics_text_query
    
    @queries = []
    @query_args = {}
    @title_text_query       and (@queries << title_text_match_query      ) and @query_args[:title]       = @title_text_query      
    @description_text_query and (@queries << description_text_match_query) and @query_args[:description] = @description_text_query
    @lyrics_text_query      and (@queries << lyrics_text_match_query     ) and @query_args[:lyrics]      = @lyrics_text_query     
    @queries.push *@genres.map {|genre| "genres.id = #{genre.to_i}" unless genre.to_i == 0} if @genres
    @queries.push *@moods.map {|mood| "moods.id = #{mood.to_i}" unless mood.to_i == 0} if @moods
    @queries.push *@instruments.map {|instrument| "instruments.id = #{instrument.to_i}" unless instrument.to_i == 0} if @instruments

    @query = @queries.join( " OR\n").insert 0, "\n"
    
    unless @queries.empty?
      @result = @result.includes(:genres) if @genres
      @result = @result.includes(:moods) if @moods
      @result = @result.includes(:instruments) if @instruments
      @result = @result.where(@query, title: @title_text_query, description: @description_text_query, lyrics: @lyrics_text_query)
    end
    
    @result = @result.order(@order) unless @ranks.empty?
    
    @result
  end
  
  
  
private
  
  def text_selection query
    [
      title_text_selection(query),
      description_text_selection(query),
      lyrics_text_selection(query)
    ]
    .join(" ,\n").insert 0, "\n"
  end
  
  def title_text_selection query;       "#{headline :title,       query} AS title_headline"       end
  def description_text_selection query; "#{headline :description, query} AS description_headline" end
  def lyrics_text_selection query;      "#{headline :lyrics,      query} AS lyrics_headline"      end
  
  def headline column, query, config=headline_config
    "ts_headline('english', recordings.#{column}, plainto_tsquery(#{sanitize query}), '#{config}')"
  end
  
  def headline_config
    options = []
    options << "StartSel = <highlight>"
    options << "StopSel = </highlight>"
    options << "MinWords=35"
    options << "MaxWords=85"
    
    options.join(', ').insert 0, "\n"
  end
  
  def text_match_query
    [
      title_text_match_query,
      description_text_match_query,
      lyrics_text_match_query
    ]
    .join(" OR\n").insert 0, "\n"
  end
  
  def title_text_match_query;       "(to_tsvector('english', title)       @@ plainto_tsquery('english', :title))" end
  def description_text_match_query; "(to_tsvector('english', description) @@ plainto_tsquery('english', :description))" end
  def lyrics_text_match_query;      "(to_tsvector('english', lyrics)      @@ plainto_tsquery('english', :lyrics))" end
  
  def text_rank query
    [
      title_text_rank(        query ),
      description_text_rank(  query ),
      lyrics_text_rank(       query )
    ]
    .join(" +\n").insert 0, "\n"
  end
  
  def title_text_rank       query; "ts_rank(to_tsvector(title),       plainto_tsquery(#{sanitize query}))" end
  def description_text_rank query; "ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize query}))" end
  def lyrics_text_rank      query; "ts_rank(to_tsvector(lyrics),      plainto_tsquery(#{sanitize query}))" end
  
  @@sanitize_memoizer = {}
  
  def sanitize string
    @@sanitize_memoizer[string] ||= Recording.sanitize(string)
  end
end