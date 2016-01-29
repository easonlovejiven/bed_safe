class ProductsController < ApplicationController

	before_action :get_product, only: [:edit, :show, :destroy, :update, :change_top_and_down, :change_discount]
	before_action :get_type, only: [:new, :create, :edit, :update, :show, :index]
	before_action :get_user, only: [:new, :create, :edit, :update, :show, :index]
	before_action :get_product_user, only: [:index]
	
	def index
		@q = Product.ransack(params[:q])
		@q = Product.created_at_gte(params[:created_at_gteq]).created_at_lte(params[:created_at_lteq]).search(params[:q])
		@products = @q.result.paginate(page: params[:page], per_page: 5).order('id DESC')
		@products = @products.where(type_id: params[:type_id]) if params[:type_id].present? #点击不同产品类型找到相关的产品

	# respond_to do |format|
  #   format.html 
  #   format.csv { send_data @base_stocks.to_csv }
  #   format.xls { send_data @base_stocks.to_csv(col_sep: "\t") }
  # end
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

  def fetch_products
  	@productss = Product.where(type_id: params[:type_id])
    #render :aaa #fetch_products  (js/html)模版
  end

  # 改成ajax批量删除
	# <%= link_to '删除', p, method: :delete, data: {confirm: "你确定删除吗？"} %>
	# def destroy
  #   @product.destroy
  #   redirect_to products_path
	# end

	def create
		@product = Product.new(product_params)
	  if @product.save
	  	redirect_to products_path
	  else
	  	render :new
		end
	end

	# 导入csv, xls, xlsx
	def import_c_name
    if !params[:file].nil?
      begin
        BaseStock.import_c_name(params[:file])
        message = "导入成功"
      rescue Exception => e
        message = "导入失败，请确认文件类型为csv、xls或xlsx"
      end
    else
      message = "请选择文件"
    end
    redirect_to admin_base_stocks_path, notice: message
  end

	
  # def create
  #    @forbidden_name = ForbiddenName.create(word: params[:word].to_s.strip)
  #    notice = @forbidden_name.valid? ? "创建成功" : "已存在"
  #    redirect_to admin_forbidden_names_path, notice: notice
  #  end

	def change_top_and_down
		@product.top_and_down? ? @product.update(top_and_down: false) : @product.update(top_and_down: true)
    redirect_to :back
	end

	def change_discount
		@product.discount? ? @product.update(discount: false) : @product.update(discount: true)
    redirect_to :back
	end

	def ajax_del_product
		params[:ids].split(",").each{|id|
      m = Product.find(id).destroy
    }
    render text: "ok"
	end

	def search_user
    users = User.search_by(params[:q], 5).map{|u| u.attributes.slice("id", "username")}
    render json: {users: users, q: params[:q]}
	end

	def show
		@product.increment!(:views_count)
	end

	private
	def product_params
		params.require(:product).permit(:name, :price, :discount, :top_and_down, :product_date, :type_id, :image, :describtion, :user_id)
	end

	def get_product
    @product ||= Product.find(params[:id])
  end

  def get_type
  	@types = Type.pluck("name", "id")
  end

  def get_user
    @users = User.pluck("username", "id")
  end

  def get_product_user
  	@product_user = params[:q].present? && params[:q][:user_id_eq].present? ? User.where(id: params[:q][:user_id_eq]).pluck(:id, :username).flatten : []
  end
end