class ProductsController < ApplicationController

	before_action :get_product, only: [:edit, :show, :destroy, :update]
	before_action :get_type, only: [:new, :create, :edit, :update, :destroy, :show]
	
	def index
		#@products = Product.paginate(page: params[:page], per_page: 10)
		@q = Product.ransack(params[:q])
		@products = @q.result.paginate(page: params[:page], per_page: 10)
	end

	def new	
		@product = Product.new
	end

	def edit
	end

	def destroy
    @product.destroy
    redirect_to products_path
	end

	def create
		@product = Product.new(product_params)
	  if @product.save
	  	redirect_to product_path
	  else
	  	render :new
		end
	end

	def destory
		if @product.update_attributes(product_params)
      redirect_to products_path
    else
      render :edit
    end
	end

	def show
	end

	private
	def product_params
		params.require(:product).permit(:name, :price, :discount, :top_and_down, :product_date, :type_id)
	end

	def get_product
    @product ||= Product.find(params[:id])
  end

  def get_type
  	@types = Type.all.pluck("name")
  end
end