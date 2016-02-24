require 'hashids'

# PrettyId 加密实现类
# 
# 用来生成10位字母的伪ID
# 
# 调用方式:
#   Caishuo::Utils::Encryption.pretty_id(datas)
module Caishuo::Utils::Encryption

 
  class PrettyId

    SALT = 'cawi23s43!hu*o'
    LENGTH = 10

    ENGINE = Hashids.new(SALT, LENGTH)

    class << self

      # Encoding
      # Caishuo::Utils::Encryption::PrettyId.encode(obj_id)
      def encode(obj_id)
        PrettyId::ENGINE.encode(obj_id)
      end

      def decode(pretty_id)
        PrettyId::ENGINE.decode(pretty_id)
      end
     
    end
  end

end