#window.playerNamespace = angular.module 'playerApp', []
window.playerNamespace= angular.module("playerApp", ["ngResource"])

playerNamespace.controller('PlayerCtrl' , 

  @PlayerCtrl = ($scope, $resource) ->
    
    #Recording = $resource("api/players.json", {id: "@id"}, {update: {method: "PUT"}, index: { method: 'GET', isArray: true}})
    Recording =  $resource("/api/players/:id/", { id: "@id" },
     {
       'create':  { method: 'POST' },
       'index':   { method: 'GET', isArray: true },
       'show':    { method: 'GET', isArray: false },
       'update':  { method: 'PUT' },
       'destroy': { method: 'DELETE' }
      }
    );
    
    
    
    
    $scope.recordings = Recording.query()
    
    
    for recording in $scope.recordings
      recording.status = 'PLAY'
      
      
      
    $scope.play = (index, status) ->
      
      # turn off all tracks
      for recording in $scope.recordings 
        recording.status = 'PLAY'
      
      # swap state on current track
      $scope.recordings[index]['status'] =  'STOP'
      #if status == 'PLAY'
      #  $scope.recordings[recording_id]['status'] =  'STOP'
      #else
      #  $scope.recordings[recording_id]['status'] =  'PLAY'
      #alert track_id
    
)