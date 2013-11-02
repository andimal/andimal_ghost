$(window).load ->
	$('footer .caption').each ->
		iconWidth			= $(this).parent().outerWidth()
		captionWidth	= $(this).outerWidth()
		
		$(this).css('left', -( (captionWidth / 2) - (iconWidth / 2) ) )

	isToTopVisible = false;
	$(window).scroll ->
		if !isToTopVisible && $(window).scrollTop() >= 400
			$('.header-icons').addClass('show-to-top')
			isToTopVisible = true;
		else if isToTopVisible && $(window).scrollTop() < 400
			$('.header-icons').removeClass('show-to-top')
			isToTopVisible = false;

	$('.to-top').click ->
		$('html, body').animate scrollTop : 0