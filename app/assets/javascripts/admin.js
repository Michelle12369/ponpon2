//= require jquery
//= require jquery-ui/effect-slide
//= require jquery.Jcrop
//= require jquery.atwho
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require bindWithDelay
//= require ./admin/base
//= require ./user/posts

	var window_w = $(window).width();
	var h = $('.fade1').height();
	if( window_w > 560 ){
		$(window).scroll(function() {
			if($(window).scrollTop()> 300){
				// $(".fade1").fadeTo( 1000 , 1);
				$('.fade1').animate({ marginLeft : "-5%", opacity: 1 }, 1500);
			}
			if($(window).scrollTop()> (300 + 2 * h) ){
				// $(".fade1").fadeTo( 1000 , 1);
				$('.fade2').animate({ marginRight : "-5%", opacity: 1 }, 1500);
			}
			if($(window).scrollTop()> 300 + 3 * h){
				// $(".fade1").fadeTo( 1000 , 1);
				$('.fade3').animate({ marginLeft : "-5%", opacity: 1 }, 1500);
			}
		});
	}
	if( window_w <= 560 ){
		$('.fade').css('opacity',1);
	}