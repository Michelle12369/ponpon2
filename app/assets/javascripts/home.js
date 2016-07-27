// console.log(gon.resource);
$(document).ready(function(){
    var a=[];
    var d= $(".temp_information").data('temp');
    a.push(d);
    console.log(a);
    console.log(d);
    $(".comment-"+d).click(function(){
         $("#comment-form-"+d).show("slow");
    });
   
})
