// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* General Functions
-------------------- */                     

function remove_field(element, item) {
  element.parents(item).remove();
}

jQuery(function($) {
  $(".ajax_photo_item")
    //.bind("ajax:loading",  toggleLoading)
    //.bind("ajax:complete", toggleLoading)
    .bind("ajax:success", function(data, status, xhr) {
      // why not data?!?
      $(this).fadeOut();
  });
});