class VotesController < AuthController
  protect_from_forgery with: :null_session
  before_action :set_vote, only: %i[ show edit update destroy ]
  before_action :get_vote, only: %i[new]
  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
    #@clip = Clip.find(@vote.clip.id)
    #count = Clip.count
    # random_offset = rand(count)
    # @clip = Clip.offset(random_offset).first
  end

  # POST /votes or /votes.json
  def create
      @vote = Vote.new(vote_params)

      if @vote.save!
        clip = Clip.find(@vote.clip_id)
        clip.update(is_valid: @vote.is_valid,need_vote: false)

        respond_to do |format|  
        format.html { redirect_to votes_url(@vote), notice: "Vote was successfully created." }
        end
      else
        render :new 
      end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    def get_vote

      # We want to avoid the user to have to validate an audio of other user linked to a sentence he has also submitted
      #user_submitted_sentences_clips_for_other_users = Clip.find(current_user.sentences.pluck("id"))
      # 
      user_clips_validated = current_user.clips

      user_clips_created = current_user.records

      clips = Clip.where(need_vote: true).without(user_clips_validated).without(user_clips_created)
      #.without(user_submitted_sentences_clips_for_other_users)
      
      random_offset = rand(clips.count)
      @clip = clips.offset(random_offset).first
    end
    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:is_valid,:clip_id,:user_id)
    end
end
