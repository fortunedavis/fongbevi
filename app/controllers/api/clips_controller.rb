class Api::ClipsController < Api::AuthController
  respond_to :json

  def index
    sentences = Sentence.where(has_clip: false)
    random_offset = rand(sentences.count)
    @sentence = sentences.offset(random_offset).first

    render json: @sentence
  end


  def create
    #@clip = Clip.create(clip_params)
    #render json: @clip

    @clip = Clip.new(clip_params.merge({ user: current_user }))
    
    respond_to do |format|
      if @clip.save!
        
        sentence_id = @clip.sentence_id
        UserSentence.create(user: current_user, sentence_id: sentence_id)
        Sentence.find(sentence_id).update(has_clip: true)
        #We need to set the sentence has_clip params to true if the clip is saved
        #sentence = Sentence.find(sentence_id)
        #sentence.update(has_clip: true)
        format.json {render json:@clip, status: :ok}
      else
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end

  end


  private

  # Only allow a list of trusted parameters through.
  def clip_params
    params.require(:clip).permit(:is_valid,:need_votes,:audio,:sentence_id,:user_id)
  end

end
