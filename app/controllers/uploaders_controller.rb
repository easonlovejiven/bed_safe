class UploadersController < ApplicationController

	def create
    @upload = Uploader.new
    @upload.store! params[:file]
  end
end