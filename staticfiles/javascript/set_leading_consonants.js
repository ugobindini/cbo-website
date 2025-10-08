$(document).ready(function(){
  $(".consonant-space").each(function() {
    $(this).html($(this).html().split(/[aeiouAEIOUyYůöǒêœ].*/));
  });
});