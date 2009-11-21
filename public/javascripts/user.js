$(document).ready(function() {
  var charsRemaining = 140;
  $("div.status_form textarea").keyup(function() {
    charsRemaining = 140 - $(this).val().length;
    $("#count").text(charsRemaining);
    if (charsRemaining >= 0 && charsRemaining < 140) {
      $("div.status_form input.button").removeAttr("disabled");
    }
    else {
      $("div.status_form input.button").attr("disabled", "disabled");
    }
    if (charsRemaining < 0) {
      $("#count").addClass("red");
    }
    else {
      if($("#count").is(".red")) {
        $("#count").removeClass("red");
      }
    }
  });
});