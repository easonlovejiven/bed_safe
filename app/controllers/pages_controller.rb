class PagesController < ApplicationController

	def show
		type = params[:type]
		case type
		when type == "topics"
			topics
		when type == "articles"
			articles
		when type == "announcements"
			announcements
		when news == "news"
			news
		else
			unknown
		end
		#send(params[:type])
	end

	private

	def topics
		@type = "topices"
	end

	def articles
		@type = "articles"
	end

	def announcements
		@type = "announcements"
	end

	def news
		@type = "news"
	end

	def unknown
		@type = "扩展中......"
	end

end