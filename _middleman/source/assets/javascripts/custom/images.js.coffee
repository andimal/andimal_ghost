$ ->
  $('.content img').each ->
    $_this = $(this)
    if $_this.attr('alt')
      $container = $('<div class="image-container" data-caption="' + $_this.attr('alt') + '" />')
      $_this.before( $container )
      $_this.appendTo( $container )
