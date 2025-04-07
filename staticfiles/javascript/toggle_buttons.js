$(document).ready(function(){
  $("#stressedSyllablesButton").click(function(){
    $(".syl[data-met='+']").toggleClass("font-bold");
  });
});

$(document).ready(function(){
  $("#toggleMetricButton").click(function(){
    $(".verse-met").toggle();
    $(".verse-real").toggle();
    var text = $(this).text().includes("Show") ? 'Hide metrical analysis' : 'Show metrical analysis';
    $(this).text(text)
  });
});

$(document).ready(function(){
  $("#toggleRhymeButton").click(function(){
    $(".verse-rhyme").toggle();
    var text = $(this).text().includes("Show") ? 'Hide rhyme scheme' : 'Show rhyme scheme';
  });
});