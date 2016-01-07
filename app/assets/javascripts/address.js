$(function(){
  
  area.liveClick();
  area.init();  
  
})

// 所在地
var area = {
  init: function(){
    $('.selectoption li.active').each(function(){
      $(this).parents('.selectbox').find('input').val($(this).attr('data-value'));
      $(this).parents('.selectbox').find('label').text($(this).text());
    })

    $('.provinces li').on('click', function(){
      $.getScript('/ajax/region/cities?province_id=' + $(this).attr('data-value'));
    })
  },

  setValue: function(element){
    element.parents('.selectbox').find('input').val(element.attr('data-value'));
    element.parents('.selectbox').find('label').text(element.text());
    element.addClass('active').siblings().removeClass();
    element.parent().hide();
    return false;
  },

  liveClick: function(){
    $('.selectoption li').on('click', function(){
      area.setValue($(this));
      return false;
    })
  },

  updateCity: function(){
    var selected = $(".cities li.active");
    if(selected.length == 0){
      selected = $(".cities li:first");
    }
    selected.parents('.selectbox').find('input').val(selected.attr('data-value'));
    selected.parents('.selectbox').find('label').text(selected.text());
  }
}
