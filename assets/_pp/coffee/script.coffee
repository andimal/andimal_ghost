$(window).load ->
	$('.caption').each ->
		iconWidth			= $(this).parent().find('a').outerWidth()
		captionWidth	= $(this).outerWidth()
		
		$(this).css('left', -( (captionWidth / 2) - (iconWidth / 2) ) )
