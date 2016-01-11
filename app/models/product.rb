class Product < ActiveRecord::Base
	belongs_to :type

	scope :created_at_day, -> (created_at_day) { where("created_at >= ? and created_at < ?", created_at_day.to_time, created_at_day.to_time + 1.days) }
end
