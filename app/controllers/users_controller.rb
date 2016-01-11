class UsersController < ApplicationController
  before_action :internal_facecontrol, only: [:new, :create]
  before_action :facecontrol, only: [:index, :show, :edit, :destroy]

  def index
    @users = User.order(id: :asc).paginate(page: params[:page], per_page: 5)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = 'Profile was deleted'
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to SBlog !'
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :avatar)
  end
end
