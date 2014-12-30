class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    FollowUpEmailJob.new(@user.email).enqueue
    redirect_to '/users/new'
  end

  def user_params
    params[:user].permit(:email)
  end
end
