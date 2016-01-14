class Product < ActiveRecord::Base
	belongs_to :type

	DISCOUNT = { 0 => "没有折扣", 1 => "有折扣" } # 默认是有折扣的
  TOP_AND_DOWN = { 0 => "已下架", 1 => "未下架" } # 默认是未下架

end
