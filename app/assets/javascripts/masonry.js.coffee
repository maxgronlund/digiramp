ready = ->

  $('.opportunity-badges').masonry ->
    columnWidth: '.container-fluid',
    itemSelector: '.opportunity-container'


$(document).ready(ready)
$(document).on('page:load', ready)


#.js-masonry data-masonry-options='{ "columnWidth": 314, "itemSelector": ".opportunity-badge" }'

  