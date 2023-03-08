class Api::AuthController < ApplicationController
  before_action :authenticate_user!
end
