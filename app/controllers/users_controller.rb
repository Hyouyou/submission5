class UsersController < ApplicationController
before_action :authenticate_user!

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
  	#マイページ
    @user = User.find(params[:id])
    #新規投稿
    @book = Book.new
    #current_userのデータだけ引っ張ってくる
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user.id == current_user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully'
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def follow
    @user = User.find(params[:id])
    @follow_users = @user.followings
  end

  def follower
    @user = User.find(params[:id])
    @follower_users = @user.followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
