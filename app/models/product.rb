class Product < ActiveRecord::Base
	belongs_to :type

	DISCOUNT = { 0 => "没有折扣", 1 => "有折扣" } # 默认是有折扣的
  TOP_AND_DOWN = { 0 => "已下架", 1 => "未下架" } # 默认是未下架

  # 按照日期进行搜索

  scope :created_at_gte, -> (date_str) { date_str.present? ? where("created_at >= ?", Date.parse(date_str)) : all}
  scope :created_at_lte, -> (date_str) { date_str.present? ? where("created_at <= ?", Date.parse(date_str) + 1) : all}
end
