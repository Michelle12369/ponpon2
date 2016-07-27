console.log("I am home.js");
$(document).on("click", '.vendor-link', function(event) { 
     var id = $(this).data("id");
        console.log(id);
        $("#comment-form-" + id).show("slow");
});