$ ->
  $.stellar()

$(document).on 'click', '#about', ->
  $('header').addClass('show-about')

$(document).on 'click', '#back-to-header', ->
  $('header').removeClass('show-about')