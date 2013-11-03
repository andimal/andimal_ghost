gifViewer = ($span, href) ->
	$viewer = 	$('<div class="gif-viewer">' +
								'<img src="' + href + '" />' +
							'</div>')
	$('body').append($viewer)
	
	setViewerPosition = ->
		$viewer.css
			top		: $span.offset().top - $viewer.outerHeight()
			left	: $span.offset().left - ( $viewer.outerWidth() / 2 ) + ( $span.outerWidth() / 2 )

	setViewerPosition()

	$(window).resize ->
		setViewerPosition()
	
	$span.hover ->
		$viewer.stop().fadeIn()
	, ->
		$viewer.stop().fadeOut()

$(window).load ->
	$('.post-content a').each ->
		$(this).attr('target', '_blank')	

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

	$('.gif').each ->
		gifViewer( $(this), $(this).attr('data-href') )



