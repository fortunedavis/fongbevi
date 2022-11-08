class Admin::UsersController < ApplicationController
  layout "admin"
  def index
    #@items = params[:items] || 25
    @users = User.all
    #@pagy, @users = pagy(@users, items: @items)
   # @users = @users.decorate
  end


  def my_account
    @user = current_user
  end  
end
