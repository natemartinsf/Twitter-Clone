$(document).ready(function() {
  $(".popup").hide();
  $("li#following").mouseover(
    function() {
      if(!$(".popup").is(".following_pop"))
        {
          var position = $("li#following").offset();
          position.left -= 220;
          position.top -= 30;
          var username = this.className;
          //$(".popup #middle").empty();
          $(".popup #middle").load("/ajax/"+username+"/following/");
          $(".popup").addClass("following_pop");
          //$(".popup").css("visibility", "visible");
          $(".popup").fadeIn("slow");
          $(".popup").css(position)
        }
    }
  );
  $(".sidebar").mouseleave(
    function() {
      
      $(".popup #middle").empty();
      //$(".popup").css("visibility", "hidden");
      $(".popup").fadeOut("slow");
      
      $(".popup").removeClass("following_pop");  
      
    }
  );
  $("li#followers").mouseover(
    function() {
      if(!$(".popup").is("followers_pop"))
      {
        var position = $("li#followers").offset();
        position.left -= 220;
        position.top -= 30;
        var username = this.className;
        //$(".popup #middle").empty();
        $(".popup #middle").load("/ajax/"+username+"/followers/");

        $(".popup").addClass("followers_pop");
        //$(".popup").css("visibility", "visible");
        $(".popup").fadeIn("slow");  
        $(".popup").css(position)
        
      }

      
    }
  );
  $(".sidebar").mouseleave(
    function() {
      $(".popup #middle").empty();
      
      //$(".popup").css("visibility", "hidden");
      $(".popup").fadeOut("slow");
      
      $(".popup").removeClass("followers_pop"); 
       
    }
  );
});