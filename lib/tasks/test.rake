namespace :channel_codes do
  desc '初始化渠道下载页数据'
  task init_channel_code_by_area: :environment do
    # //存在就修改不存在就添加
    # channel_code_hash = {
    #   "sogou" => [false, false, 4, false, true, false],
    #   "yy_jike" => [false, false, 15, false, true, false]
    # }
    # channel_code_hash.map{ |key, value|
    #   channel_code = ChannelCode.find_or_initialize_by(code: key.to_s)
    #   channel_code.assign_attributes(code: key.to_s, media: key.to_s, show_desc: value[0], full_screen: value[1], market_templete_id: value[2], change_above: value[3], change_middle: value[4], change_below: value[5])
    #   channel_code.save
    # }
    Type.create(name: "测试rake")
  end
end
