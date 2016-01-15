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

 });