class Api::Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    user = User.find_by(email: params[:email])
    puts user
    if user&.valid_password?(params[:password])
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: 'invalid' }
    end
  end
  
  def fetch
    render json: current_user
  end


  private

  def respond_with(resource, _opts = {})
    render json: { message: 'You are logged in..' }, status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Hmm nothing happened."}, status: :unauthorized
  end
end
