$(document).ready(function(){

	// faq頁面
	var j = 0;
	for( var i=1 ; i<=($('li').length) ; i++){
		if(i%2==1){
			$('.faq > ul > li:nth-child('+i+')').prepend('<div class="icon"><span class="Q">Q'+(i-j)+'</span></div>');
			j++;
		}
		if(i%2==0){
			$('.faq > ul > li:nth-child('+i+')').prepend('<div class="icon"><span class="A">A'+(i-j)+'</span></div>').hide();
		}
		$('.faq > ul > li:nth-child('+i+')').click(function(){
			// var k = i+1;
			// $('.row > ul > li:nth-child('+k+')').show();
			// slideDown("slow");
		})
	}

	$('li:nth-child(odd)').click(function(){
		$(this).next().slideToggle('fast');
	})


});




