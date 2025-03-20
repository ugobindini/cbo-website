$(document).ready(function(){
  $("#showNeumesButton").click(function(){
    $(".neumes").show();
    $(".syl-dash").show();
  });
});

$(document).ready(function(){
  $("#hideNeumesButton").click(function(){
    $(".neumes").hide();
  });
});

$(document).ready(function(){
  $("#plainTextButton").click(function(){
    $(".neumes").hide();
    $(".syl-dash").hide();
  });
});

$(document).ready(function(){
  $("#stressedSyllablesButton").click(function(){
    $(".stressed-syl").toggleClass("font-bold");
  });
});