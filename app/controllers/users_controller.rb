class UsersController < ApplicationController
  def index
    @users = User.all.decorate
  end

  def show
    @user = User.find_by_id(params[:id]).decorate
  end
end
