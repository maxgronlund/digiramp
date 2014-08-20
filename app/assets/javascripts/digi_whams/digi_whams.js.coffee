#soundManager.setup =() ->
#  #disable or enable debug output
#  debugMode: false,
#  #use HTML5 audio for MP3/MP4, if available
#  preferFlash: false,
#  useFlashBlock: true,
#  #path to directory containing SM2 SWF
#  url: '../../swf/',
#  #optional: enable MPEG-4/AAC support (requires flash 9)
#  flashVersion: 9,
#  html5PollingInterval: 100









# make sure it works with turbolinks
ready = ->
 digiWhamsNamespace.loadWhams()
  

  
$(document).ready(ready)
$(document).on('page:load', ready)






