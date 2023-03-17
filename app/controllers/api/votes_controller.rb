class Api::VotesController < Api::AuthController
  respond_to :json

  def index
    user_clips_validated = current_user.clips

    user_clips_created = current_user.records

    clips = Clip.where(need_vote: true).without(user_clips_validated).without(user_clips_created)

    random_offset = rand(clips.count)

    @clip = clips.offset(random_offset).first

    render json: @clip
  end

  def create
    @vote = Vote.new(vote_params)
    if @vote.save!
      clip = Clip.find(@vote.clip_id)
      clip.update(is_valid: @vote.is_valid,need_vote: false)

      respond_to do |format|  
        format.json {render json:@vote, status: :ok}
      end
    else
      format.json { render json: @vote.errors, status: :unprocessable_entity }
    end
  end


end
