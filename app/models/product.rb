class Product < ActiveRecord::Base
	belongs_to :type
	belongs_to :user

	DISCOUNT = { false => "没有折扣", true => "有折扣" } # 默认是有折扣的
  TOP_AND_DOWN = { false => "已下架", true => "未下架" } # 默认是未下架

  # 按照日期进行搜索
  scope :created_at_gte, -> (date_str) { date_str.present? ? where('created_at >= ?', Date.parse(date_str)) : all }
  scope :created_at_lte, -> (date_str) { date_str.present? ? where('created_at <= ?', Date.parse(date_str) + 1) : all }
end
