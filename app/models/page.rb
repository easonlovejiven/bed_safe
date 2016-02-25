# model层
class Page
	TYPE = %w[ topics articles announcements news ]

	def initialize(type, id)
		@type = type
		@id = id
	end

	# Setting.host用来设置项目环境

	def url
		"#{Setting.host}/xxxxxx/pages/#{@type}/#{@id}"
	end

end

# controller层
class PagesController < ApplicationController

	def show
		send(params[:type])
	end

	def topics
		result_type
	end

	def articles
		result_articles
	end

	def announcements
		result_announcements
	end

	def news
		result_news
	end

end

# routes层
get 'xxxxx/pages/:type/:id' => "xxxxx/pages#show"

# view层

#根据不同的type判断显示不同的 result_type