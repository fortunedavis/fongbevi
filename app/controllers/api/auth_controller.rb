class Api::AuthController < ApplicationController
  #skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def show
    render json: { message: "If you see this, you're in!" }
  end
end
