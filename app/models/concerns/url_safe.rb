# url参数base64加密
# 
# 调用方式:
#   Caishuo::Utils::Encryption::UrlSafe.encode("xxx")
module Encryption

  class UrlSafe

    class << self
      def encode(str)
        Base64.urlsafe_encode64(str)
      end

      def decode(str)
        Base64.urlsafe_decode64(str)
      end
    end
    
  end

end