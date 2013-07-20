//= require_tree .
//= require_bower_dependencies

$(document).ready(function() {
	var speed = 10;

	$('section').each(function() {
		var $backgroundObject = $(this);

		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var yPosition = -(scrollTop / speed);
			var coords = '50% ' + yPosition + 'px';
			$backgroundObject.css({ backgroundPosition: coords});

			handleBackToTop(scrollTop);
		})
	});


	$('nav a').each(function() {
		var button = $(this);

		button.click(function() { 
			var sectionName = button.attr('href');
			scrollTo(sectionName);
		});
	});
});

var fading = false;

function handleBackToTop(scrollTop) {
	if(scrollTop > 100) {
		$('body > header').addClass('pinned');
	} else if(scrollTop <= 100) {
		$('body > header').removeClass('pinned');
	}
}

function onFadeComplete() { 
	fading = false;
}

function scrollTo(sectionName) {
	var topOffset = $(sectionName).offset().top;
	$('html, body').animate({scrollTop:topOffset},'5000');
}

