class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    Rails.logger.debug "[Admin::UsersController#index] Params received: #{params.inspect}"

    @users = User.all

    if params[:name].present?
      Rails.logger.debug "[Admin::UsersController#index] Filtering by name: #{params[:name]}"
      @users = @users.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%")
    end

    if params[:email].present?
      Rails.logger.debug "[Admin::UsersController#index] Filtering by email: #{params[:email]}"
      @users = @users.where("LOWER(email) LIKE ?", "%#{params[:email].downcase}%")
    end

    if params[:address].present?
      Rails.logger.debug "[Admin::UsersController#index] Filtering by address: #{params[:address]}"
      @users = @users.where("LOWER(address) LIKE ?", "%#{params[:address].downcase}%")
    end

    if params[:role].present?
      Rails.logger.debug "[Admin::UsersController#index] Filtering by role: #{params[:role]}"
      @users = @users.where(role: params[:role])
    end

    Rails.logger.debug "[Admin::UsersController#index] Final user count: #{@users.count}"
  end

  def new
    @user = User.new
  end

  def create
    Rails.logger.debug "[Admin::UsersController#create] Creating user with params: #{user_params.inspect}"

    @user = User.new(user_params)
    if @user.save
      Rails.logger.debug "[Admin::UsersController#create] User created successfully: #{@user.inspect}"
      redirect_to admin_users_path, notice: "User created successfully"
    else
      Rails.logger.debug "[Admin::UsersController#create] Failed to create user: #{@user.errors.full_messages}"
      render :new, alert: "Failed to create user"
    end
  end

  private

  def ensure_admin
    unless current_user.admin?
      Rails.logger.warn "[Admin::UsersController#ensure_admin] Unauthorized access attempt by user: #{current_user.id}"
      redirect_to root_path, alert: "Access denied"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :role, :password, :password_confirmation)
  end
end
