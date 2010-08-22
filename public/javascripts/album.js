$(document).ready(function() {
  $(document).click(function() {
    $(".action_box").hide();
  });
  
  $(".photo_thumb").click(function() {
    var action_box = $(".action_box", this);
    $(".action_box").not(action_box).hide();
    action_box.toggle();
    return false; // prevent event bubbling
  });
  
  $(".action_box").click(function() {
    return false;
  });
  
  $(".action_box a").click(function() {
    window.location = this.href;
    return false;
  });

});