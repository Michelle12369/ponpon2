$(document).ready(function(){
  $(".amount-button").on("click", function() {
    var $button = $(this);
    var oldValue = $(".people-amount").val();
    console.log(oldValue);
    if ($button.text() == "+") {
      var newVal = parseFloat(oldValue) + 1;
    } else {
     // Don't allow decrementing below zero
      if (oldValue > 0) {
        var newVal = parseFloat(oldValue) - 1;
      } else {
        newVal = 0;
      }
    }

    $(".people-amount").val(newVal);

  });
});
