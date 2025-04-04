$(document).ready(function(){
  $(".verse").each(function() {
    var indent = $(this).data("indent");
    $(this).children(".verse-text").css("padding-left", "calc(" + indent + " * 20px");
  });
});