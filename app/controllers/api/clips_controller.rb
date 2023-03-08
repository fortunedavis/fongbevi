class Api::ClipsController < Api::AuthController
  def index
    @sentences = Sentence.all
    render json: @sentences
  end


  def create
    clip = Clip.create(clip_params)

    
    render json: clip
  end


  private

  # Only allow a list of trusted parameters through.
  def clip_params
    params.require(:clip).permit(:is_valid, :need_votes,:audio,:sentence_id,:user_id)
  end
end
