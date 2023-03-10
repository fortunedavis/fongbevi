class Api::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  respond_to :json
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end
  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?
    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end


 # private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,:fullname, :sex, :age, :country, :role)
  end

  #def respond_with(resource, _opts = {})
  #  register_success && return if resource.persisted?

   # register_failed
  #end

  #def register_success
  #  render json: { message: 'Signed up sucessfully.' }
 # end

  #def register_failed
   # render json: { message: "Something went wrong." }
  #end
end
