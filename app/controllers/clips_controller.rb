class ClipsController < AuthController
  wrap_parameters format: []
  rescue_from ActionController::UnpermittedParameters, with: :render_unpermitted_params_response

  before_action :set_clip, only: %i[ show edit update destroy ]

  # GET /clips or /clips.json
  def index
    @clips = Clip.all
  end

  # GET /clips/1 or /clips/1.json
  def show
  end

  # GET /clips/new
  def new
    sentences = Sentence.where(status: false)
    sentences.without(current_user.sentences)
    random_offset = rand(sentences.count)
    @sentence = sentences.offset(random_offset).first
    @clip = Clip.new
  end

  # GET /clips/1/edit
  def edit
  end

  # POST /clips or /clips.json
  def create
    @clip = Clip.new(clip_params)
    @clip.user = current_user
   
    respond_to do |format|
      if @clip.save!
        format.html { redirect_to clip_url(@clip), notice: "Enrégistré avec succès" }
        format.json { render :show, status: :created, location: @clip }
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clips/1 or /clips/1.json
  def update
    respond_to do |format|
      if @clip.update(clip_params)
        format.html { redirect_to clip_url(@clip), notice: "Clip was successfully updated." }
        format.json { render :show, status: :ok, location: @clip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clips/1 or /clips/1.json
  def destroy
    @clip.destroy

    respond_to do |format|
      format.html { redirect_to clips_url, notice: "Clip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clip
      @clip = Clip.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clip_params
      params.require(:clip).permit(:is_valid, :need_votes,:audio,:sentence_id,:user_id)
    end
end
