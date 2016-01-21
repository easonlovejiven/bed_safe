class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :user

	# 有命名空间
	# belongs_to :sender_staffer, class_name: "Admin::Staffer", foreign_key: :sender_staffer_id #生产者
  # belongs_to :audit_staffer, class_name: "Admin::Staffer", foreign_key: :audit_staffer_id #送货员

  # 无命名空间 product.product_user/product.product.deliver 得到固定产品的生产者和配送者
  # belongs_to :product_user, class_name: :User, foreign_key: :product_user_id #生产者
  # belongs_to :product_deliver, class_name: :User, foreign_key: :product_deliver_id #送货员

	DISCOUNT = { false => "没有折扣", true => "有折扣" } # 默认是有折扣的
  TOP_AND_DOWN = { false => "已下架", true => "未下架" } # 默认是未下架

  # 按照日期进行搜索
  scope :created_at_gte, -> (date_str) { date_str.present? ? where('created_at >= ?', Date.parse(date_str)) : all }
  scope :created_at_lte, -> (date_str) { date_str.present? ? where('created_at <= ?', Date.parse(date_str) + 1) : all }
end
