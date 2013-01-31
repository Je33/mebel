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

$.fn.cardfly = (o) ->
  o = $.extend(
    basket: "none"
    animspeed: 1000
    sdv: -10
  , o)
  @each ->
    btn = $(this).parent().parent()
    clone = btn.clone().addClass("clone-block")
    posX = btn.offset().left
    posY = btn.offset().top
    posXb = o.basket.offset().left
    posYb = o.basket.offset().top
    clone.css("position", "absolute").css("top", posY).css("left", posX).css("z-index", "2000").css "border", "1px solid #999999"
    $("body").append clone
    $(".clone-block").animate
      left: posXb + parseInt(o.sdv)
      top: posYb + parseInt(o.sdv)
      width: "50px"
      height: "50px"
      opacity: 0.2
    , o.animspeed, ->
      $(this).remove()


$ ->
  $('.add_to_shopping_cart').bind 'click', ->
    $(this).cardfly {
      basket: if $('.shopping_cart_link:visible').get(0) then $('.shopping_cart_link') else $('.basket')
    }

  $('.scl').bind 'click', ->
    if $('.shopping_cart').hasClass('open') == false
      $('.shopping_cart')
        .addClass('open')
        .show()
      $('.shopping_box').tinyscrollbar({ axis: 'x'})
    else
      $('.shopping_cart')
        .removeClass('open')
        .hide()
    return false
  $('.shop_cart_close').bind 'click', ->
    $('.shopping_cart')
      .removeClass('open')
      .hide()

  $('.coll_change').find('i').bind 'click', ->
    coll = parseInt( $(this).parent().find('.coll').text() )
    if $(this).hasClass('icon-minus') == true && coll > 1
      $(this).parent().find('.coll').text( coll - 1 )
    if $(this).hasClass('icon-plus') == true && coll < 99
      $(this).parent().find('.coll').text( coll + 1 )


  M.menu_slide()
  M.slider()
  M.filter_slide()

