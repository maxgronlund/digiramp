module SharedCommonWorksHelper
  
  # create permissions
  def create_common_work
    @catalog        = Catalog.cached_find(params[:shared_catalog_id])
    @recording      = Recording.cached_find(params[:shared_recording_id])
    forbidden unless @recording.create_common_work_ipis_ids.include? current_user.id || can_edit?
  end
  
  # read permissions
  def read_common_work
    @catalog        = Catalog.cached_find(params[:shared_catalog_id])
    @recording      = Recording.cached_find(params[:shared_recording_id])
    @common_work    = @recording.common_work
    forbidden unless @recording.read_common_works_ids.include? current_user.id || can_edit?
  end
  
  
  
  # update permissions
  def update_common_work
    @catalog        = Catalog.cached_find(params[:shared_catalog_id])
    @recording      = Recording.cached_find(params[:shared_recording_id])
    @common_work    = @recording.common_work
    forbidden unless @recording.update_common_works_ids.include? current_user.id || can_edit?
  end
  
  
  # delete permissions
  def delete_common_work
    @catalog        = Catalog.cached_find(params[:shared_catalog_id])
    @recording      = Recording.cached_find(params[:shared_recording_id])
    @common_work    = @recording.common_work
    forbidden unless @recording.delete_common_work_ipis_ids.include? current_user.id || can_edit?
  end
  
  
  
  
  
end
