// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var readURL = function(input, preview) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(preview).parent().removeClass('hidden-xs-up');
      $(preview).attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
};




$(document).ready(function(){
  if($(".pagination").size() > 0) {
    $(".pagination").hide();
    $("#endless-scroll").removeClass("hidden-xs-up");
    $(window).bindWithDelay("scroll", function(){
      var url = $("a.next_page").attr("href");
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $.getScript(url);
      }
    }, 150);
  }


  $('.nav-search-glass').click(function(){
    $('.search-friend').slideToggle("fast");
  });
  $('.alert-notice,.alert-alert').fadeIn(1000).delay(4000).fadeOut(1000);


  var preview = "#img-preview > img";

  $("#post-attachment").click(function(){
    $("#post_attachment").click();
  });

  $('#post_attachment').change(function(){
    readURL(this, preview);
  });

    $("#admin-post-attachment").click(function(){
    $("#admin_post_attachment").click();
  });

  $('#admin_post_attachment').change(function(){
    readURL(this, preview);
  });


//   $('.input-mentionable').atwho({
//     at: '@',
//     data: $('#mentionable-data').data('content'),
//     insertTpl: '${name}',
//     displayTpl: '<li data-id="${id}"><span>${name}</span></li>',
//     limit: 15
//   });

});
