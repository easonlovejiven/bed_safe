class WelcomeController < ApplicationController
	def index
		now = Time.now
		#  这里做具体的操作(Product.all)
		@seconds = (Time.now - now).round(5)
	end
end