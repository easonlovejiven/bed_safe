# 加密工具集的统一出口
# 
# 方法命名规则:
#   加密方法: 对应实现类的
#   解密方法名为：  "decode_" + 对应的加密方法名
module Encryption
  class << self

    def md5(datas)
      Encryption::MD5.encode(datas)
    end

    def pretty_id(obj_id)
      PrettyId.encode(obj_id)
    end

    def decode_pretty_id(obj_id)
      PrettyId.decode(obj_id)
    end

  end
end

require "md5"
require "pretty_id"
require "url_safe"