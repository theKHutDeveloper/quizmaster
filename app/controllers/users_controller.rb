# Controller for User
class UsersController < ApplicationController
  before_action :require_admin, only: %i[index, destroy]
  before_action :require_user, only: %i[new, show, edit, destroy]

  def index
    @page_title = "Subscribed Users"
    @users = User.all.paginate(page: params[:page], per_page: 5)
  end

  def new
    @page_title = "Sign up"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def edit
    @page_title = "Edit User Details"
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = 'Successfully updated user'
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def show
    @page_title = "Show User Details"
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
  end
end
