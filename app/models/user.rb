class User < ActiveRecord::Base
	include Paperclip::Glue #头像上传
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
	has_secure_password
 	before_create {generate_token(:auth_token)}
	# validates :email, :password_digest, presence: {:message => '不能为空！'}
 #  validates :username, :email, :realname, uniqueness: { message: "不能重复！", case_sensitive: false } #这块儿区分大小小
 #  validates :username, length: {minimum: 6, maximum: 12, message: "长度不合法！"}
	GENDERS = {"男" => true, "女" => false}.invert

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end
end
