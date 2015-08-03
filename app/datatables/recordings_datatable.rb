require_relative 'datatable'

class RecordingsDatatable < Datatable
  Columns = %w[
    recordings.title
    recordings.description
    recordings.artists
    recordings.isrc_code
    recordings.bpm
    recordings.duration
    recordings.instrumental
    recordings.explicit
    recordings.lyrics
    recordings.release_date
  ]
  TextSortColumns = %w[
    recordings.description
    recordings.artists
    recordings.lyrics
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
      duration = recording.duration.strftime('%H:%M:%S') if recording.duration
      instrumental = recording.instrumental ? '<i class="icon-ok"></i>&nbsp;Instrumental' : '' unless recording.instrumental.nil?
      explicit = recording.explicit ? '<i class="icon-exclamation-sign"></i>&nbsp;Explicit' : '' unless recording.explicit.nil?
      release_date = recording.release_date.strftime('%Y - %-m - %-d') if recording.release_date
      
      path = @controller.account_common_work_recording_path(@account, recording.get_common_work, recording)
      title = path ? link_to(recording.title, path) : h(recording.title)
      
      mini_player = @controller.render_to_string partial: 'recordings/mini_player', locals: {recording: recording}
      
      result = {
        title: title,
        description: h(recording.comment),
        artists: h(recording.artists),
        isrc_code: h(recording.isrc_code),
        bpm: h(recording.bpm),
        duration: h(duration),
        instrumental: @controller.render_to_string(partial: 'recordings/instrumental', locals: {recording: recording}),
        explicit: @controller.render_to_string(partial: 'recordings/explicit',     locals: {recording: recording}),
        lyrics: h(recording.lyrics),
        release_date: release_date,
        manage: @controller.render_to_string(partial: 'recordings/manage_buttons', locals: {recording: recording}),
        mini_player: mini_player
      }
      
      
    end
  end
  
  def recordings
    @recordings ||= fetch_recordings
  end
  
  def fetch_recordings
    if TextSortColumns.include? sort_column
      order = "NULLIF(#{sort_column}, '') #{sort_direction}  NULLS LAST"
      recordings = @account.recordings.select("recordings.*, NULLIF(#{sort_column}, '')").order(order)
    else
      order = "#{sort_column} #{sort_direction} NULLS LAST"
      recordings = @account.recordings.order(order)
    end
    
    recordings = recordings.page(page).per(per_page)
    
    if params[:sSearch].present?
      search recordings, params[:sSearch]
      return merge_relations @search_results if @search_results.length > 0
    end
    
    return recordings.uniq
  end
  
  def search _recordings, search_string
    @search_string = search_string.dup
    @search_results = []
    search_by_instrumental _recordings
    search_by_text _recordings
  end
  
  def search_by_text _recordings
    search_query = [
      "recordings.title ilike :search"
    ].join(' or ')
        
    @search_string.split(' ').each do |word|
      add_search_result _recordings.where(search_query, search: "%#{word}%", raw: word)
    end
  end
  
  def search_by_instrumental _common_works
    #puts "search_by_instrumental"
    #search_not_instrumental_recordings _common_works
    #search_instrumental_recordings _common_works
    #puts "search_by_instrumental done"
  end
  
  def search_not_instrumental_recordings _common_works
    #if match = @search_string.match(/((?<!\S)(not|no|non|minus|exclude(s?)|\-)((\s*)|\-)(instrumental(s?)))|vocal/i)
    #  @search_string.gsub!(match.to_s, '')
    #  @search_string.strip!
    #  add_search_result _common_works.where("recordings.instrumental IS FALSE")
    #end
  end
  
  def search_instrumental_recordings _common_works
    #if match = @search_string.match(/(?<!\S)(plus|include(s?)|only|(\s*)|\+)instrumental(s?)/i)
    #  @search_string.gsub!(match.to_s, '')
    #  add_search_result _common_works.where("recordings.instrumental IS TRUE")
    #end
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