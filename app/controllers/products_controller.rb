class ProductsController < ApplicationController

	before_action :get_product, only: [:edit, :show, :destroy, :update, :change_top_and_down, :change_discount]
	before_action :get_type, only: [:new, :create, :edit, :update, :destroy, :show, :index]
	
	def index
		@q = Product.ransack(params[:q])
		@q = Product.created_at_gte(params[:created_at_gteq]).created_at_lte(params[:created_at_lteq]).search(params[:q])
		@products = @q.result.paginate(page: params[:page], per_page: 5).order('id DESC')

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
		binding.pry
		@product = Product.new(product_params)
	  if @product.save
	  	redirect_to products_path
	  else
	  	render :new
		end
	end

	def change_top_and_down
		@product.top_and_down? ? @product.update(top_and_down: false) : @product.update(top_and_down: true)
    redirect_to :back
	end

	def change_discount
		@product.discount? ? @product.update(discount: false) : @product.update(discount: true)
    redirect_to :back
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
		params.require(:product).permit(:name, :price, :discount, :top_and_down, :product_date, :type_id, :image, :describtion)
	end

	def get_product
    @product ||= Product.find(params[:id])
  end

  def get_type
  	@types = Type.pluck("name", "id")
  end
end