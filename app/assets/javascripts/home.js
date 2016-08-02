console.log("I am home.js");
$(document).on("click", '.comment-btn', function(event) { 
     var id = $(this).data("id");
        console.log(id);
        $("#comment-form-" + id).fadeIn("slow");
});
