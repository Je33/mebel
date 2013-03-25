$ ->
  $('input.filter').change ->
    arr = []
    $('input.filter').each ->
      if $(this).is(':checked')
        arr.push $(this).attr('title')
    $.ajax
      url: "/catalog/ajax_category"
      type: "post"
      data:
        cat: $('#products').attr('data-category')
        vals: arr
      success: (resp) ->
        $('#products').html(resp)