class Api::Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    user = User.find_by(email: params[:email])
    #puts user
    if user&.valid_password?(params[:password])
      #sign_in(:user, user)
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: 'Identifiant invalid' }, status: :unprocessable_entity
    end
  end
  
  def fetch
    render json: current_user
  end

  def destroy
    # Revoke JWT and run default logout action.
    token = request.headers.env['HTTP_AUTHORIZATION'].to_s.split('Bearer ').last
    revoke_token(token)
    # Delete Authorization header
    request.delete_header('HTTP_AUTHORIZATION')
    super
  end

  private

  def revoke_token(token)
    secret = Rails.application.credentials.devise.jwt_secret_key
    #secret = Rails.application.credentials.devise_jwt_secret

    jti = JWT.decode(token, secret, true, algorithm: 'HS256', verify_jti: true)[0]['jti']
    exp = JWT.decode(token, secret, true, algorithm: 'HS256')[0]['exp']
    # Add record to blacklist. 
    sql_blacklist_jwt = "INSERT INTO jwt_denylists(jti, exp) VALUES ('#{ jti }', '#{ Time.at(exp) }');"
    ActiveRecord::Base.connection.execute(sql_blacklist_jwt)
  end


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
