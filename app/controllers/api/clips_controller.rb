class Api::ClipsController < Api::AuthController
  respond_to :json

  def index
    sentences = Sentence.where(has_clip: false)
    random_offset = rand(sentences.count)
    @sentence = sentences.offset(random_offset).first

    render json: @sentence
  end


  def create

    clip = Clip.new(clip_params.merge({ user: current_user }))

    clip.audio.attach(params[:audio])

    if clip.save!
        sentence_id = clip.sentence_id
        UserSentence.create(user: current_user, sentence_id: sentence_id)
        Sentence.find(sentence_id).update(has_clip: true)
      render json: { success: true }

    else
      render json: { success: false, errors: clip.errors }
    end
  end


  private

  # Only allow a list of trusted parameters through.
  def clip_params
    params.require(:clip).permit(:is_valid,:need_votes,:audio,:sentence_id,:user_id)
  end

end
