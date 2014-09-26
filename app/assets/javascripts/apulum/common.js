// Sticky Header
$(window).scroll(function() {

    if ($(window).scrollTop() > 100) {
        $('.main_h').addClass('sticky');
    } else {
        $('.main_h').removeClass('sticky');
    }
});

// Mobile Navigation
$('.mobile-toggle').click(function() {
    if ($('.main_h').hasClass('open-nav')) {
        $('.main_h').removeClass('open-nav');
    } else {
        $('.main_h').addClass('open-nav');
    }
});

$('.main_h li a').click(function() {
    if ($('.main_h').hasClass('open-nav')) {
        $('.navigation').removeClass('open-nav');
        $('.main_h').removeClass('open-nav');
    }
});

// navigation scroll lijepo radi materem
$(function() {
    $('a.logo, nav a, .home-buttons a, a.introarrow, a.footerarrow').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1000, 'easeInOutExpo');
        event.preventDefault();
    });
});


// init animations on appear
 var wow = new WOW(
  {
    boxClass:     'wow',      // animated element css class (default is wow)   
    mobile:       false        // trigger animations on mobile devices (true is default)
  }
);
wow.init();
 

// tooltip
$(function() {
    $('.homepage a').tooltip({placement: 'bottom'});
});

// carousel
$(document).ready(function() {
 
  $("#wowtestim").owlCarousel({
 
      navigation : false, // Show next and prev buttons
      slideSpeed : 50,
      paginationSpeed : 400,
	  autoPlay : false,
      items : 1
 
      // "singleItem:true" is a shortcut for:
      // items : 1, 
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false
 
  });
 
});
	
// carousel
$(document).ready(function() {
 
  $("#wowcarousel").owlCarousel({
 
      navigation : false, // Show next and prev buttons
      slideSpeed : 100,
      paginationSpeed : 700,
	  autoPlay : false, 
      items : 2
 
      // "singleItem:true" is a shortcut for:
      // items : 1, 
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false
 
  });
 
});
