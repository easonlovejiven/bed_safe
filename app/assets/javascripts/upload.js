;(function ($) {
  
  $.fn.uploader = function(options){
    var $this = $(this),
        csrf_token = $("meta[name=csrf-token]").attr("content");
    $.fn.uploader.defaults = $.extend({}, $.fn.uploader.defaults, options);
    var dialogHtml = '\
      <div class="div_common_uploader">\
        <form target="curform" class="real-file" enctype="multipart/form-data" action="/uploaders" accept-charset="UTF-8" method="post">\
          <input type="hidden" name="_method" value="post" />\
          <input type="hidden" name="authenticity_token" value="">\
          <input type="file" name="file" id="real_avatar" accept="%accept_type%"/>\
        </form>\
      </div>\
    '.replace(/%accept_type%/g, $.fn.uploader.defaults.accept_type);
    $(".div_common_uploader").remove();
    $("body").append(dialogHtml);
    $("form input[name=authenticity_token]").val(csrf_token);

    $($this).click(function(){
      $('#real_avatar').trigger('click');
    });

    $("#real_avatar").change(function(){
      var currentForm = $(this).parents("form");
      if($("iframe[name='curform']").length > 0){
        var thisIframe = $("iframe[name='curform']");
      }else{
        var thisIframe = $("<iframe style='opacity:0;_filter:alpha(opacity=0)'></iframe>").attr("name",currentForm.attr("target"));
      }

      $(currentForm).after(thisIframe);
      $(currentForm).submit();
      $this.after("<uploader>上传中。。。请稍后</uploader>");
      $("#real_avatar").val("");
      //上传......
    });
  };

  $.fn.uploader.defaults = {
    url_field_id: "common_uploader_input",  //上传成功后，要更新url的input的id
    accept_type: "image/png,image/gif,image/jpeg,image/bmp",
    image_show_id: "",
    a_link_id: ""
  };

  $.fn.uploader.success = function(url){
    $("#" + $.fn.uploader.defaults.url_field_id).val(url);
    $("#" + $.fn.uploader.defaults.url_field_id).parent().find("uploader").remove();
    $("#" + $.fn.uploader.defaults.image_show_id).attr("src", url);
    $("#" + $.fn.uploader.defaults.a_link_id).attr("href", url);
  };

})(jQuery);
