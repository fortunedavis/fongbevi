class Api::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      sign_in(user)
      render json:{user: user}
    else
      render json: { errors: 'Identifiant invalid' }, status: :unprocessable_entity
    end
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

  def respond_with(resource, _opts = {})
    render json: { message: 'You are logged in.' }, status: :ok
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

  def revoke_token(token)
    secret = "4e3bbe5f62e2802054a107959391760de04c07ced214af7aad7405a7d121e2011e7d1adf88cda0c1fbecac5bbfb4b91430b9b8c76e3f483505af0446d272f40b"
    jti = JWT.decode(token, secret, true, algorithm: 'HS256', verify_jti: true)[0]['jti']
    exp = JWT.decode(token, secret, true, algorithm: 'HS256')[0]['exp']
    puts "revoke method"
    # Add record to blacklist
    sql_blacklist_jwt = "INSERT INTO jwt_denylists(jti, exp) VALUES ('#{ jti }', '#{ Time.at(exp) }');"
    ActiveRecord::Base.connection.execute(sql_blacklist_jwt)
  end
end
