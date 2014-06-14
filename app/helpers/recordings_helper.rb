module RecordingsHelper
  
  # delete recording permissions
  #def create_recording
  #  @recording      = Recording.cached_find(params[:id])
  #  forbidden unless @recording.delete_recording_ids.include? current_user.id || can_edit?
  #end
  
  # read recording permissions
  def read_recording
    
    @recording      = Recording.cached_find(params[:id])
    #forbidden unless @recording.read_recording_ids.include? current_user.id || can_edit?
  end
  
  # update recording permissions
  def update_recording
    @recording      = Recording.cached_find(params[:id])
    forbidden unless @recording.update_recording_ids.include? current_user.id || can_edit?
  end
  
  
  # delete recording permissions
  def delete_recording
    @recording      = Recording.cached_find(params[:id])
    forbidden unless @recording.delete_recording_ids.include? current_user.id || can_edit?
  end
  
  
end
