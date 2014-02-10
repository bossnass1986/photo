jQuery ->
  $("#sorted-image-list").sortable
    handle: "div.title"
    revert: true
    update: ->
      $.ajax
        type: "put"
        data: $("#sorted-image-list").sortable("serialize")
        dataType: "script"
        url: $("meta[name=sortable_path]").attr("content")
        complete: (request) ->
          $("#message").html("<div class='alert-box success radius' data-alert>Your changes have been saved.<a href='#' class='close'>×</a></div>").fadeIn "slow"
          $("#message").html("<div class='alert-box success radius' data-alert>Your changes have been saved.<a href='#' class='close'>×</a></div>").delay(3000).fadeOut "slow"
          return


  $("a[data-remote=\"true\"]").on "ajax:error", (xhr, status, error) ->
    alert "Ran into a problem with this record."

  $(".delete").on "ajax:success", (data, status, xhr) ->
    if $(this).parents("tr").length
      $(this).parents("tr").remove()
    else $(this).parents("li").remove()  if $(this).parents("li").length

  $("#side-nav ul li a").hover (->
    $(this).prepend "<span class='fi-pencil' style='margin-left: -16px'></span> "
    return
  ), ->
    $(this).children("span").remove()
    return

  return


