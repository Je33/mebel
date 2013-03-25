M = {}
M.menu_slide = ->
  el = $('#top_menu')
  el2 = $('.cloth_cont_box')
  el22 = $('.cloth_cont_box').find('.cloth_cont')
  tpm = el.position().top
  tpm_det = el2.offset().top if el2.offset()
  $(window).scroll ()->
    _s = $(this).scrollTop()
    if  _s > parseInt( tpm )
      el.css {
        position: 'fixed'
        top: 0
        opacity: 0.5
      }
      $('.shopping_cart_link').show()
    else
      el.css {
        position: 'absolute'
        top: 60
        opacity: 1
      }
      $('.shopping_cart_link').hide()
    if  _s + 50 > tpm_det
      el22.css {
        top: _s - tpm_det + 50
      }
      $('.shopping_cart_link').show()
    else
      el22.css {
        top: 0
      }
  el.mouseenter ->
    if parseInt( $(this).css('opacity') ) < 1
      $(this).css('opacity', 1)
      el.mouseleave ->
        $(this).css('opacity', 0.5)

M.slider = () ->
    $('.slider_init').each ->
      p = $(this)
      v = p.find('.viewport')
      o = p.find('.overview')
      b = p.find('.slide_el')
      l = p.find('.slide_left')
      r = p.find('.slide_right')
      bs = b.size()
      as = true
      if p.hasClass('show_slide')
        ec = 1
        mmr = 0
      else
        ec = 4
        mmr = 20
      coll = bs / ec
      if bs > ec
        cur = 0
        o.width( b.size() *  ( parseInt( b.width() ) +  parseInt(b.css('margin-left') ) ) )
        a = () ->
          if cur < 0
            cur =  Math.ceil( bs / ec ) - 1
          if cur > Math.ceil( bs / ec ) - 1
            cur = 0
          o.stop().animate({
            marginLeft: -(ec * cur * ( parseInt( b.width() ) +  parseInt(b.css('margin-left'))  ) + mmr )
          }, 300)

        r.bind 'click', ->
          cur++
          a()
          return false

        l.bind 'click', ->
          cur--
          a()
          return false
        if as && bs > ec
          autoClick = ->
            r.trigger 'click'
          t = setInterval( autoClick, 5000 )
          p.mouseenter( ->
            clearInterval(t)
          ).mouseleave( ->
            t = setInterval( autoClick, 5000 )
          )
      else
        l.hide()
        r.hide()
M.filter_slide = () ->
  $("#slider_cell").slider(
    {
      from: 5000,
      to: 150000,
      heterogeneity: ['50/50000'],
      step: 1000,
      dimension: '&nbsp;p'
    }
  )


$ ->
  # call back
  $("a[href='#order_call']").bind 'click', ->
    if $(this).hasClass('open') == false
      $(this).addClass 'open'
      $('.black-bg').fadeIn '300'
      $('.order_call').animate {right: 0}, 300
    else
      $(this).removeClass 'open'
      $('.black-bg').fadeOut '100'
      $('.order_call').animate {right: -500}, 300
    return false
  $('.black-bg').bind 'click', ->
    $("a[href='#order_call']").removeClass 'open'
    $('.black-bg').fadeOut '100'
    $('.order_call').animate {right: -500}, 300
    return false
  $('.order_call').find('button.close').bind 'click', ->
    $("a[href='#order_call']").removeClass 'open'
    $('.black-bg').fadeOut '100'
    $('.order_call').animate {right: -500}, 300
    return false

  $(".validate").each ->
    f = $(this)
    n = $(f).find("input[name=name]")
    e = $(f).find("input[name=email]")
    p = $(f).find("input[name=phone]")
    t = $(f).find("textarea")
    s = (if $(f).find("button[name=submit]").get(0) then $(f).find("button[name=submit]") else $("button.subm"))
    v = ->
      if $(n).get(0)
        if $(n).val().length > 1
          $(n).parents(".section").removeClass "error"
        else
          $(n).parents(".section").addClass "error"
      if $(t).get(0)
        console.log($(t).val())
        if $(t).val().length > 10
          $(t).parents(".section").removeClass "error"
        else
          $(t).parents(".section").addClass "error"
      if $(p).get(0)
        unless isNaN(parseInt($(p).val()))
          if $(p).val().length > 4
            $(p).parents(".section").removeClass "error"
          else
            $(p).parents(".section").addClass "error"
        else
          $(p).parents(".section").addClass "error"
          $(p).val ""
      if $(f).find(".error").get(0)
        $(s).addClass('disabled')
      else
        $(s).removeClass('disabled')
    $(s).bind "click", ->
      v()
      if $(f).find(".error").get(0)
        $(s).addClass('disabled')
        return false
      else
        $(s).removeClass('disabled')
        return true

    $(n).bind "change, keydown", ->
      v()

    $(p).bind "change, keyup", ->
      $(p).val parseInt($(p).val())
      v()
    $(t).bind "change, keyup", ->
      v()
  $('.coll_change').find('i').bind 'click', ->
    coll = parseInt( $(this).parent().find('.coll').text() )
    if $(this).hasClass('icon-minus') == true && coll > 1
      $(this).parent().find('.coll').text( coll - 1 )
    if $(this).hasClass('icon-plus') == true && coll < 99
      $(this).parent().find('.coll').text( coll + 1 )

  $('.add_to_shopping_cart').click ->
    id = $(this).attr('data-id')
    $.ajax
      url: "/ajax/add_to_basket"
      dataType: "json"
      data:
        product_id: id
      type: "post"
      success: (resp) ->
        if resp.success
          $('.basket a span').text('('+resp.cnt+')')
          $('.scl span').text('('+resp.cnt+')')

  $('.item-minus').click ->
    id = $(this).attr('data-id')
    $.ajax
      url: "/ajax/remove_from_basket"
      dataType: "json"
      data:
        product_id: id
      type: "post"
      success: (resp) =>
        if resp.success
          $('.basket a span').text('('+resp.cnt+')')
          $(this).parent().find('.item-count').val(resp.col)
          $(this).parent().parent().find('.item-price').text(resp.price + ' p')
          $('.tottal b').text(resp.summ)
          $('.basket a span').text('('+resp.cnt+')')
          $('.scl span').text('('+resp.cnt+')')

  $('.item-plus').click ->
    id = $(this).attr('data-id')
    $.ajax
      url: "/ajax/add_to_basket"
      dataType: "json"
      data:
        product_id: id
      type: "post"
      success: (resp) =>
        if resp.success
          $('.basket a span').text('('+resp.cnt+')')
          $(this).parent().find('.item-count').val(resp.col)
          $(this).parent().parent().find('.item-price').text(resp.price + ' p')
          $('.tottal b').text(resp.summ)
          $('.basket a span').text('('+resp.cnt+')')
          $('.scl span').text('('+resp.cnt+')')

  $('.remove_cart').click ->
    if confirm("Удалить позицию из заказа?")
      id = $(this).attr('data-id')
      $.ajax
        url: "/ajax/destroy_basket"
        dataType: "json"
        data:
          basket_id: id
        type: "post"
        success: (resp) =>
          if resp.success
            $(this).parents('.one_cart').remove()
            $('.tottal b').text(resp.summ)
            $('.basket a span').text('('+resp.cnt+')')
            $('.scl span').text('('+resp.cnt+')')


  $('.remove_all').bind 'click', ->
    if confirm("Вы, действительно хотите удалть все покупки?")
      #blocks
      $('.order_list').hide()
      $('.order_form').hide()
      $('.order_confirm').hide()
      $('.tottal_text').hide()
      $('.order_none').show()
      $('.forms_block_ri').remove()
      $('.forms_block_le').removeClass('span10').addClass('span12')
  $('#myTabCloth a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
    return false

  txt = $('.zero_b p')
  fir = $('.fr_b')
  sec = $('.sec_b')
  in_sh_bx = $('.add_shoping_box')
  cloth = 0
  cloth_work = (el) ->
    data_category = ''
    data_name = ''
    data_cost = ''
    data_id = ''

    if el != 'clear'
      _t = el
      data_category = el.attr('data-category')
      data_name = el.attr('data-name')
      data_img =  el.find('img').attr('src')
      data_cost =  el.attr('data-cost')
      data_id = el.attr('data-id')
    if el != 'clear'
      if cloth == 0
        _t.addClass('select')
        txt.text 'Выберите ткань компаньон'
        cloth = 1
        $('input[name=first_cloth]').val(data_id);
        fir.find('img').attr('src', data_img)
        fir.find('p:first').text 'Основная - ' + data_name
        fir.find('p:last').text 'Класс '+data_category+' - ('+data_cost+'р.)'
        fir.show()
        fir.animate {marginLeft: 0, height: 61}, 300, ->
          in_sh_bx.removeClass('disabled')
      else if cloth == 1 && el != 'clear'
        _t.addClass('select')
        txt.text 'Нажмите кнопку "в корзину"'
        cloth = 2
        $('input[name=second_cloth]').val(data_id)
        sec.find('img').attr('src', data_img)
        sec.find('p:first').text 'Компаньон - ' + data_name
        sec.find('p:last').text 'Класс '+data_category+' - ('+data_cost+'р.)'
        sec.show()
        sec.animate {marginLeft: 0, height: 61}, 300, ->
          in_sh_bx.removeClass('disabled')
    else

      if el != 'clear'

      else
        tt =  'Вы действительно хотите очистить ткани'
      if confirm(tt)
        cloth = 0
        txt.text 'Выберите основную ткань'
        in_sh_bx.addClass('disabled')
        $('.tabbable').find('.select').removeClass('select')
        $('input[name=first_cloth]').val('')
        $('input[name=second_cloth]').val('')
        fir.find('img').attr('src', '')
        fir.find('p:first').text('Основная - ')
        fir.find('p:last').text('Компаньон - (р.)')
        fir.animate({marginLeft: 350, height: 0}, 300, ->
          $(this).hide()
        )
        sec.find('img').attr('src', '')
        sec.find('p:first').text('Основная - ')
        sec.find('p:last').text('Компаньон - (р.)')
        sec.animate({marginLeft: 350, height: 0}, 300, ->
          $(this).hide()
        )
  $('.cloth_select_cont').find('a').bind 'click', ->
    cloth_work( $(this) )
    _id = $(this).parents('.tab-pane').attr('id')
    el = $('a[href=#'+_id+']')
    el.addClass('bg_select')
  $('.clear_cloth').bind 'click', ->
    cloth_work( 'clear' )
    $('.bg_select').removeClass('bg_select')
  $('.add_shoping_box').bind('click', ->
    if $(this).hasClass('disabled')
      return false;
    else
      $(this).parents('form').trigger('submit')
  )
  $('.arr_left_box').bind 'click', ->
    _t = $(this)
    if $(this).hasClass('open') == true
      $(this).parent().stop().animate {right: -252}, 300, ->
        _t.removeClass('open')
        _t.find('.ll').show()
        _t.find('.rr').hide()
    else
      $(this).parent().stop().animate {right: 0}, 300, ->
        _t.addClass('open')
        _t.find('.ll').hide()
        _t.find('.rr').show()
  $('#img_changer').find('.sml_img').bind('click', ->
    _tsrc = $(this).attr('src')
    _bsrc = $('.big_img').attr('src')
    $('.big_img').attr('src', _tsrc)
    $(this).attr('src', _bsrc)
  )
  M.menu_slide()
  M.slider()
  M.filter_slide()






