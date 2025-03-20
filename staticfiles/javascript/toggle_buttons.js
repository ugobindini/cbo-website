$(document).ready(function(){
  $("#showNeumesButton").click(function(){
    $(".neumes").show();
    $(".syl-dash").show();
    $("#neume-app-div").show();
  });
});

$(document).ready(function(){
  $("#hideNeumesButton").click(function(){
    $(".neumes").hide();
    $("#neume-app-div").hide();
  });
});

$(document).ready(function(){
  $("#plainTextButton").click(function(){
    $(".neumes").hide();
    $(".syl-dash").hide();
    $("#neume-app-div").hide();
  });
});

$(document).ready(function(){
  $("#stressedSyllablesButton").click(function(){
    $(".stressed-syl").toggleClass("font-bold");
  });
});