# user_model
class UsersController < ApplicationController
  before_action :provinces, only: [:signup, :create, :login_session, :signup]

  # 注册页面
  def signup
    @user = User.new
  end

  # 登录页面
  def signin
  end

  # 实现登录功能
  def login_session
    user = User.where(username: params[:username])[0]
    if user #&& user.authenticate(params[:password])
      # session[:user_id] = user_id
      # if params[:remember_me]
      #   cookies.permanent[:auth_token] = user.auth_token
      # else
      #   cookies[:auth_token] = user.auth_token
      # end
      redirect_to products_path
    else
      render :signup
    end
  end

  # 实现退出功能
  # def logout
  #   #session[:user_id] = nil
  #   cookies.delete(:auth_token)
  #   redirect_to :root
  # end

  # 实现注册功能
  def create
    @user = User.new(user_params)
    if @user.save
      #cookies[:auth_token] = @user.auth_token
      render :signin, notice: '注册成功！'
    else
      render :signup, notice: '注册有误！'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :realname, :gender, :province, :city, :birthday, :detail_address, :password_digest, :avatar)
  end
  def provinces
    @provinces, @cities = CityInit.get_provinces
  end
end
