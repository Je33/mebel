M = {}
M.menu_slide = ->
  el = $('#top_menu')
  tpm = el.position().top
  $(window).scroll ()->
    if  $(this).scrollTop() > parseInt( tpm )
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
    s = $(f).find("button[name=submit]")
    v = ->
      if $(n).get(0)
        if $(n).val().length > 1
          $(n).parents(".section").removeClass "error"
        else
          $(n).parents(".section").addClass "error"
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
  $('#myTab a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'

  cloth = 0
  cloth_class = ''
  z_b = $('.zero_b p')
  f_b = $('.fr_b')
  s_b = $('.sec_b')
  b_b = $('.add_shoping_box')
  cloth_work = (el) ->
    if el != 'clear'
      _t = el
      tab_id = el.parent('.tab-pane').attr('id')
      tab_class = el.parents('.tabbable').find('li.active').find('a[cloth_class]').attr('cloth_class')
      cloth_name = el.attr('data-name')
      cloth_img =  el.find('img').attr('src')
      cloth_cost =  el.attr('data-cost')
      if cloth == 0
        _t.addClass('select')
        z_b.text 'Выберите ткань компаньон'
        cloth = 1
        cloth_class = tab_class
        f_b.find('img').attr('src', cloth_img)
        f_b.find('p:first').text 'Основная - ' + cloth_name
        f_b.find('p:last').text 'Класс '+tab_class+' - ('+cloth_cost+'р.)'
        f_b.show()
        f_b.animate {marginLeft: 0, height: 61}, 300, ->
      else if cloth == 1 && cloth_class == tab_class && el != 'clear'
        _t.addClass('select')
        z_b.text 'Нажмите кнопку "в корзину"'
        cloth = 2
        s_b.find('img').attr('src', cloth_img)
        s_b.find('p:first').text 'Компаньон - ' + cloth_name
        s_b.find('p:last').text 'Класс '+tab_class+' - ('+cloth_cost+'р.)'
        s_b.show()
        s_b.animate {marginLeft: 0, height: 61}, 300, ->
          $('.add_shoping_box').removeClass('disabled')
    else
      if cloth_class != tab_class
        if el != 'clear'
          tt = 'Вы действительно хотите выбрать ткань из этой категории. (Выбранная ткань из другой категории будет удалена)'
        else
          tt =  'Вы действительно хотите очистить ткани'
        if confirm(tt)
          cloth.length = 0
          cloth = 0
          z_b.text 'Выберите основную ткань'
          $('.add_shoping_box').addClass('disabled')
          $('.tabbable').find('.select').removeClass('select')
          $('input[name=first_cloth]').val('');
          $('input[name=second_cloth]').val('');

          f_b.find('img').attr('src', '')
          f_b.find('p:first').text('Основная - ')
          f_b.find('p:last').text('Компаньон - (р.)')
          f_b.animate({marginLeft: 350, height: 0}, 300, ->
            $(this).hide()
          )

          s_b.find('img').attr('src', '')
          s_b.find('p:first').text('Основная - ')
          s_b.find('p:last').text('Компаньон - (р.)')
          s_b.animate({marginLeft: 350, height: 0}, 300, ->
            $(this).hide()
          )
  $('.cloth_select').find('a').bind 'click', ->
    cloth_work( $(this) )
  $('.clear_cloth').bind 'click', ->
    cloth_work( 'clear' )

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

  M.menu_slide()
  M.slider()
  M.filter_slide()




