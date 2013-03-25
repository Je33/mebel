# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


status_ctrls = (id, status) ->
  switch status
    when 10 then '<a class="btn btn-small btn-info order-status" data-id="' + id + '" data-status="20">Подтвердить</a> <a class="btn btn-small btn-danger order-status" data-id="' + id + '" data-status="60">Отменить</a>'
    when 20 then '<a class="btn btn-small btn-warning order-status" data-id="' + id + '" data-status="30">Передать</a> <a class="btn btn-small btn-danger order-status" data-id="' + id + '" data-status="60">Отменить</a>'
    when 30 then '<a class="btn btn-small btn-inverse order-status" data-id="' + id + '" data-status="40">В доставку</a> <a class="btn btn-small btn-danger order-status" data-id="' + id + '" data-status="60">Отменить</a>'
    when 40 then '<a class="btn btn-small btn-success order-status" data-id="' + id + '" data-status="50">Доставлен</a> <a class="btn btn-small btn-danger order-status" data-id="' + id + '" data-status="60">Отменить</a>'
    when 50 then '<a class="btn btn-small btn-success disabled">Доставлен</a>'
    when 60 then '<a class="btn btn-small btn-danger disabled">Отменен</a> <a class="btn btn-small btn-success order-status" data-id="' + id + '" data-status="10">Восстановить</a>'
    else 'error'

status_lbls = (id, status) ->
  switch status
    when 10 then '<span class="label label-success">Новый</span>'
    when 20 then '<span class="label label-info">Подтвержден</span>'
    when 30 then '<span class="label label-warning">Передан</span>'
    when 40 then '<span class="label label-inverse">Доставка</span>'
    when 50 then '<span class="label label-success">Доставлен</span>'
    when 60 then '<span class="label label-danger">Отменен</span>'
    else 'error'

$('.order-status').live "click", ->
  id = $(this).attr "data-id"
  status = $(this).attr "data-status"
  tr = $(this).parents('tr')
  if id > 0 and status > 0
    $.ajax
      url: "/admin/ajax/status"
      dataType: "json"
      type: "post"
      data:
        id: id
        status: status
      success: (resp) =>
        if resp.success
          tr.find('.lbls').html(status_lbls(id, resp.status))
          tr.find('.ctrls').html(status_ctrls(id, resp.status))

select_cloth = (t) ->
  _t = $(t);
  if _t.hasClass('active') == true
    _t.removeClass('active')
  else
    _t.addClass('active')

close_pop = (t) ->
  _t = $(t);
  _t.parents('#popup').fadeOut(200)

$('#myTab a').click (e) ->
  e.preventDefault()
  $(this).tab('show')
  false

open_popup = () ->
  $.ajax
    url: "/admin/ajax/textures"
    type: "post"
    data:
      id: 1
    success: (data) ->
      $('body').append(data)
      $('#popup').fadeIn(200)

0