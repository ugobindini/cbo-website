function textWidth(text, context) {
  // context.font = font;
  return context.measureText(text).width;
}

$(document).ready(function(){
  const canvas = document.createElement("canvas");
  const context = canvas.getContext("2d");
  // TODO: smaller font for apparatus?
  $(".neumed-syll").each(function() {
    consonants = $(this).find(".syl-text").text().split(/[aeiouAEIOUyYůöǒêœî].*/)[0];
    if (consonants.length) { $(this).children(".neumes").css('padding-left', textWidth(consonants, context)); };
  });
});