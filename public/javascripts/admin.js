// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* General Functions
-------------------- */                     

function remove_field(element, item) {
  element.parents(item).remove();
}

$(document).ready(function() {
  $(".ajax_delete_photo_btn")
    //.bind("ajax:loading",  toggleLoading)
    //.bind("ajax:complete", toggleLoading)
    .bind("ajax:success", function(event, data, status, xhr) {
      // why not data?!?
      var that = $(this).parents('.ajax_photo_item');
      that.fadeOut(function(){
        that.remove();
      });
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
  
  $('.inline_edit_field').tipsy({gravity: 'e'});
  $('.inline_edit_field').dblclick(function(){
    $(".tipsy").hide();
  });
  
  $('.inline_edit_textarea textarea').live('keydown', function(){
    //var textarea = $(this).find('textarea');
    var textarea = $(this);
    if(!textarea.hasClass('isAutogrow')) {
      textarea.autogrow();
      textarea.addClass('isAutogrow');
    }
  });

  $('textarea').not('.rich_editor').autogrow();
  
  /* Inline Editing
   * ----------------------- */
  $(".inline_edit_field").each( function(i) {
    var field_name = $(this).attr('field_name');
    var model_name = field_name.match(/(.*)\[/)[1];
    var model_attr = field_name.match(/\[(.*)\]/)[1];
    var field_type = 'text'
    if ($(this).hasClass('inline_edit_textarea')) {
      field_type = 'textarea';
    }
    $(this).editable('', {
      method    : 'PUT',
      type      : field_type,
      name      : field_name,
      data      : function(value, settings) {
        return $.trim(value);
        /*
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
        */
      },
      cancel    : 'Cancel',
      submit    : 'OK',
      indicator : "<img src='/images/admin/spinner.gif' style='border: none'/>",
      event     : 'dblclick',
      tooltip   : 'Double-click to edit...',
      submitdata: {
        authenticity_token: AUTH_TOKEN,
        field_name: model_attr, 
        format: 'json'
      },
      callback: function(value, settings) {
        var obj = $.parseJSON(value);
        $(this).html(obj[model_name][model_attr]);
      }
    });
  });
  
});

$.fn.hasScrollBar = function() {
  //note: clientHeight= height of holder
  //scrollHeight= we have content till this height
  var _elm = $(this)[0];
  var _hasScrollBar = false; 
  if ((_elm.clientHeight < _elm.scrollHeight) || (_elm.clientWidth < _elm.scrollWidth)) {
      _hasScrollBar = true;
  }
  return _hasScrollBar;
}