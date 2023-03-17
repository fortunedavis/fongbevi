class Api::HomeController < Api::AuthController
  respond_to :json

  def index
    @clips_validated = current_user.clips.count

    @clips_created = current_user.records.count

    render json: {clips_validated: @clips_validated,clips_created: @clips_created}
  end

end
