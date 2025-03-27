$(document).ready(function(){
  $.getJSON('json/buranus.json', function(data) {
    var glyphs = [];
    $.each(data, function(i, glyph) {
      id = parseInt(glyph.n) + 1
      glyphs.push("<a><img src='img/svg/buranus" + id + ".svg'></a>");
    });

    $( "<ul/>", {
      "class": "my-new-list",
      html: glyphs.join("")
    }).appendTo("body");
  });
});