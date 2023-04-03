class Admin::UsersController < AuthController
  layout "admin"
  def index
    #@items = params[:items] || 25
    @users = User.all
    #@pagy, @users = pagy(@users, items: @items)
   # @users = @users.decorate
  end


 
end
