# keep everything inside a namespace
window.digiWhamsNamespace = {}

digiWhamsNamespace.loadWhams = ->
  if ($('#digiWhams')[0])
    $.getScript("api/digi_wham_resources" )
    
    
