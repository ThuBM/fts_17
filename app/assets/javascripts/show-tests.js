function onLinkTestClick(id, ready, doing, is_current_session){
  if (ready){
    var data = "status=Submitted";
    $.ajax({
      url: "/tests/" + id,
      type: 'PUT',
      data: data,
      success: function(data) {
        alert('Load was performed.');
      }
    });
  } else {
    if (doing && !is_current_session){
      alert("Other user is doing test!");
      window.location.replace("/tests");
    }
  }
}

$(document).ready(function(){
  var element = $("#show-test-info");
  var id = element.data("id");
  var is_current_session = element.data("is-current-session");
  var doing = element.data("doing");
  var ready = element.data("ready");

  onLinkTestClick(id, ready, doing, is_current_session);
});