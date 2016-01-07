class AjaxController < ApplicationController

  def fetch_cities
    @cities = CityInit.get_cities_by_province_code(params[:province_id])
    respond_to do |format|
      format.js
      format.json { render json: { cities: @cities.map(&:name)} }
    end
  end

end
