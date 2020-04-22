class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @book = Book.new
  	@users = User.all
    @user_info = current_user
  end

  def show
    @books = Book.new
  	@user = User.find(params[:id])
    @book = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
        flash[:notice_a] = 'You have updated user successfully.'
        redirect_to user_path(@user.id)
     else
        @users = User.find(params[:id])
        render action: :edit
     end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    if params[:id].to_i != current_user.id
      redirect_to user_path(current_user)
    end
  end
end
