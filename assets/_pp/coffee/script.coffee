$(window).load ->
	$('footer .caption').each ->
		iconWidth			= $(this).parent().outerWidth()
		captionWidth	= $(this).outerWidth()
		
		$(this).css('left', -( (captionWidth / 2) - (iconWidth / 2) ) )