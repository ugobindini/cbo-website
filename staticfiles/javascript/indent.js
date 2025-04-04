$(document).ready(function(){
  $(".verse").each(function() {
    var indent = $(this).data("indent");
    $(this).children(".verse-text").css("margin-left", "calc(" + indent + " * 20px");
  });
});