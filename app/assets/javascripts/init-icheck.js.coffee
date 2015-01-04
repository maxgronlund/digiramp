ready = ->
  icheck = ->
    if $(".icheck-me").length > 0
      $(".icheck-me").each ->
        $el = $(this)
        skin = (if ($el.attr("data-skin") isnt `undefined`) then "_" + $el.attr("data-skin") else "")
        color = (if ($el.attr("data-color") isnt `undefined`) then "-" + $el.attr("data-color") else "")
        opt =
          checkboxClass: "icheckbox" + skin + color
          radioClass: "iradio" + skin + color
  
        $el.iCheck opt
        return
  
    return
  $ ->
    icheck()
    return
  

  
$(document).ready(ready)
$(document).on('page:load', ready)