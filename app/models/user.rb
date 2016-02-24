class User < ActiveRecord::Base
	include Paperclip::Glue #头像上传
	# has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 #  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
	# has_secure_password
 # 	before_create {generate_token(:auth_token)}
	# validates :email, :password_digest, presence: {:message => '不能为空！'}
 #  validates :username, :email, :realname, uniqueness: { message: "不能重复！", case_sensitive: false } #这块儿区分大小小
 #  validates :username, length: {minimum: 6, maximum: 12, message: "长度不合法！"}
  has_many :products
	GENDERS = {"男" => true, "女" => false}.invert
	validate :at_least_one_of_email_and_mobile

	# 双向关系 可以 user.product_products 得到这个人所有生产的产品  user.deliver_products 得到这个人所有配送的产品
  # has_many :product_products, foreign_key: :product_product_id, class_name: 'Product', dependent: :destroy
  # has_many :deliver_products, foreign_key: :deliver_product_id, class_name: 'Product', dependent: :destroy

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def self.search_by(term, limit = 10)
    self.where("username like ?", "#{term}%").limit(limit)
  end

  # 注册时手机号和邮箱至少填写一个
  
  def at_least_one_of_email_and_mobile
    if [self.mobile, self.email].all?(&:blank?)
      errors[:base] << "邮箱和手机号不能同时为空!"
    end
  end
  
end
