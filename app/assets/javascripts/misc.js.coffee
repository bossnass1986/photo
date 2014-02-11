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

#Date Auto Complete and form validation
(->
  $(document).ready ->

    $('input[type="text"]').keyup ->
      empty = false
      $('input[type="text"]').each ->
        empty = true  if $(this).val() is ""
      if empty
        $('input[type="submit"]').attr 'disabled', 'disabled'
      else
        $('input[type="submit"]').removeAttr 'disabled'

    date_input = $("#private_gallery_expires_on")
    date_string = $("#date")
    date = null
    input_empty = Date.parse("today").toString("dddd, MMMM dd, yyyy")
    empty_string = 'i.e today, next friday, tuesday june 25'
    date_input.val input_empty
    date_string.text empty_string
    date_input.keyup () ->
      date_input.removeClass "error"
      date_string.removeClass "error"
      if date_input.val().length > 0
        date = Date.parse(date_input.val())
        if date isnt null
          date_input.removeClass()
          date_string.removeClass()
          date_string.addClass("info").text "You are entering: " + date.toString("dddd, MMMM dd, yyyy")
        else
          date_input.addClass "error"
          date_string.addClass("error").text "I'm not sure what this means..."
      else
        date_string.text(empty_string).addClass "empty"

    date_input.focus () ->
      if date_input.val() is input_empty
        date_input.val ""
      else
        date_string.fadeIn()

    date_input.blur () ->
      if date_input.val() is ""
        date_input.val(input_empty).removeClass()
      else
        date_input.val date.toString("dddd, MMMM dd, yyyy")
        date_string.fadeOut()

)()



