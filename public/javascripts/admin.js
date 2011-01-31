// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* General Functions
-------------------- */                     

function remove_field(element, item) {
  element.parents(item).remove();
}

$(document).ready(function() {
  $(".ajax_photo_item")
    //.bind("ajax:loading",  toggleLoading)
    //.bind("ajax:complete", toggleLoading)
    .bind("ajax:success", function(event, data, status, xhr) {
      // why not data?!?
      //$(this).fadeOut();
    });
  
  $(".ajax_toggle_published")
    //.bind("ajax:loading",  toggleLoading)
    //.bind("ajax:complete", toggleLoading)
    .bind("ajax:success", function(event, data, status, xhr) {
      obj = jQuery.parseJSON(data);
      if(obj.status == "success") {
        $(this).text(obj.text);
      }
    });
});

$(document).ready(function() {
  // To avoid 406 not acceptable
  $.ajaxSetup({
    beforeSend: function (xhr) {
      xhr.setRequestHeader("Accept", "text/javascript, text/html, application/xml, text/xml, */*");
    }
  });
  
  $('.edit_textfield').tipsy({gravity: 'e'});
  $('.edit_textfield').dblclick(function(){$(".tipsy").hide();});

  /* Inline Editing
   * ----------------------- */
  $(".edit_textfield").each( function(i) {
    var url = $(this).parent('tr').attr('url');
    var field_name = $(this).attr('field_name');
    var prev_html = $(this).html();
    $(this).editable(url, {
      method    : 'PUT',
      type      : 'textarea',
      name      :  field_name,
      data      :  function(value, settings) {
        try {
          var elem = $(value);
          if (elem.html() == null) {
            return value;
          } else {
            return elem.html();
          }
        } catch(err) {
          return value;
        }
      },
      cancel    : 'Cancel',
      submit    : 'OK',
      indicator : "<img src='/images/admin/spinner.gif' />",
      event     : 'dblclick',
      tooltip   : 'Double-click to edit...',
      submitdata: {
        authenticity_token: AUTH_TOKEN,
        field_name: $(this).attr('field_name').match(/\[(.*)\]/)[1], 
        format: 'json'
      },
      callback: function(value, settings) {
        /*
        var elem = $(prev_html);
        if (elem.html() == null) {
          $(this).html(value);
        } else {
          elem.html(value);
          $(this).html(elem.outerHTML());
        }
        */
        var obj = $.parseJSON(value);
        $(this).html(obj.album.title);
      }
    });
  });
  
});