require_relative 'datatable'

class AccountPlaylistsDatatable < Datatable
  Columns = %w[
    playlists.title
  ]
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Playlist.count,
      iTotalDisplayRecords: playlists.total_count,
      aaData: data
    }
  end

  private
  
  def data
    playlists.map do |playlist|
      {
        title:        @controller.render_to_string(partial: 'playlists/td_title',     locals: {playlist: playlist}),
        tracks:       @controller.render_to_string(partial: 'playlists/td_tracks',    locals: {playlist: playlist}),
        widget:       @controller.render_to_string(partial: 'playlists/td_widget',    locals: {playlist: playlist}),
        admin:        @controller.render_to_string(partial: 'playlists/td_admin',     locals: {playlist: playlist, account: @controller.send(:current_user).account})
      }      
    end
  end
  
  def playlists
    return @playlists if @playlists
    @account = Account.find(params[:account_id])
    @playlists = @account.playlists.where(*search_query)
    @playlists = @playlists.order(order) unless sort_column.to_s.contains_nothing?
    @playlists = @playlists.page(page).per(per_page)
  end
  
  def search_query
    if params[:sSearch].present?
      queries =["playlists.title ilike :search"]
      [queries.join(" or "), search: "%#{params[:sSearch]}%"]
    else
      [""]
    end
  end
  
  def order
    "lower(#{sort_column}) #{sort_direction} NULLS LAST"
  end
end