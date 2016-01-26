# 加命名空间
namespace :types do
  desc '初始化渠道下载页数据'
  task init_type: :environment do
    Type.create(name: "测试rake2")
  end
end
# 不加命名空间
desc '初始化渠道下载页数据'
task init_type: :environment do
  Type.create(name: "测试rake2")
end
# 不加rake描述
task init_type: :environment do
  Type.create(name: "测试rake2")
end