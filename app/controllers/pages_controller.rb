class PagesController < ApplicationController

	def show
		send(params[:type])
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

end