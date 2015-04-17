// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require jquery.datetimepicker

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var expression = "_[0-9]+_";
  var regexp = new RegExp(expression, 'g');

  content = content.replace(regexp, "_" + new_id + "_");
  expression = association + "_attributes\]\[[0-9]+\]";
  regexp = new RegExp(expression, 'g');
  $(link).parent().before(content.replace(regexp, association + "_attributes][" + new_id + "]"));
}

function remove_fields(field) {
  $(field).prev().val("true");
  $(field).parent().hide();
}

function secondPassed() {
  var minutes = Math.round((seconds - 30)/60);
  var remainingSeconds = seconds % 60;
  if (remainingSeconds < 10) {
    remainingSeconds = "0" + remainingSeconds;  
  }
  $("div#countdown").html(minutes + ":" + remainingSeconds);
  if (seconds <= 0) {
    clearInterval(countdownTimer);
    $("div#countdown").html("Time out");
    $("#status").val("Completed");
    $("#submit-button").click()
  } else {
    seconds--;
  }
}

function clearIntervals(highestTimerId){
  for (var i = 0; i < highestTimerId; i++)
    clearInterval(i);
}