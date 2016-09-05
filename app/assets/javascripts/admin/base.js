$(document).ready(function(){
	console.log("hi");
	$("#toggle-button").click(function(){
	  	$('#navbar-fixed-left').toggle('slide', {
	            direction: 'left'
	        }, 500);
	});
	$(".show-sub-item").click(function(){
		if ( $(this).siblings(".sub-left-bar-item").is( ":hidden" ) ) {
			$(this).siblings(".sub-left-bar-item").slideDown("fast");
			$(this).find(".icon").removeClass("fa-angle-left");
			$(this).find(".icon").addClass("fa-angle-down");
			$(this).addClass("sub-active");
		}else{
			$(this).siblings(".sub-left-bar-item").slideUp("fast");
			$(this).find(".icon").removeClass("fa-angle-down");
			$(this).find(".icon").addClass("fa-angle-left");
			$(this).removeClass("sub-active");
		}

	});
  
});