class ProductsController < ApplicationController

	before_action :get_product, only: [:edit, :show, :destroy, :update]
	before_action :get_type, only: [:new, :create, :edit, :update, :destroy, :show, :index]
	
	def index
		@q = Product.ransack(params[:q])
		@products = @q.result.paginate(page: params[:page], per_page: 5).order("id DESC")
	end

	def new	
		@product = Product.new
	end

	def edit
	end

	def update
    if @product.update_attributes(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

	def destroy
    @product.destroy
    redirect_to products_path
	end

	def create
		@product = Product.new(product_params)
	  if @product.save
	  	redirect_to products_path
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
		params.require(:product).permit(:name, :price, :discount, :top_and_down, :product_date, :type_id, :image)
	end

	def get_product
    @product ||= Product.find(params[:id])
  end

  def get_type
  	@types = Type.pluck("name", "id")
  end
end