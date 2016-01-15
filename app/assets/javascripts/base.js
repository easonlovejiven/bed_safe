$(function() {

	// 日期插件儿
  $('.datetimepicker').datepicker({
    autoclose: true,
    language: 'ZH',
    pickTime: false,
    minView: 'month',
    format: 'yyyy-mm-dd'
  });

  // 展示更多js控制
  var arrcomments = $(".describtion"); //提取循环显示的多个字块
  arrcomments.each(function(){  //每个字块函数
    var len = 0;
    var s = $(this).text();   //获取字块字符串  
    var l = $(this).text().length;  //获取字块字符串长度
    var n = 60; //设置字符长度
    for (var i = 0; i < l; i++) {
      len += 1;
      if (len > n) break;
    }
    if(l > i){
      $(this).attr("title",s); //将文本所有内容用标签的title属性提示文本全部内容
      s=$(this).text(s.substring(0,n)+"..."); //截取后的文字后面加...输出
    }
  });

  //批量删除规范
  $('.top_tree').click(function(){
    $('.bottom_tree').prop('checked','checked');
    if(this.checked){
      $('.bottom_tree').prop("checked",true)
    }else{
      $('.bottom_tree').prop("checked",false)
    }
  });
  $('.bottom_tree').click(function(){
    var count = 0;
    var checkArry = $('.bottom_tree');
    for (var i = 0; i < checkArry.length; i++) { 
      if(checkArry[i].checked == true){
        count++;
      }
    }
    if(count == checkArry.length){
      $('.top_tree').prop("checked",true)
    }else{
      $('.top_tree').prop("checked",false)
    }
  });

 });


  // 删除选中的product 执行删除操作
  function get_checkbox(){
    ids = []
    ids = get_checkout_ids();
    if(ids.length > 0){
      var c = confirm("你确定删除吗？")
      if (c == true) {
        $.post("/products/ajax_del_product?ids="+ids,{},function(){
          location.reload();
        })
      }else{
        location.reload();
      }
    }else{
      alert("请选择要删除的消息!")
    }
  }

  // 选中ids
  function get_checkout_ids(){
    var ids = [];
    var bottoms = $('.bottom_tree')
    for(var i=0;i<bottoms.length;i++){  
      if(bottoms[i].checked){
        ids.push(bottoms[i].value)
        $("#check_"+i).remove();
      }
    }
    return ids
  }
