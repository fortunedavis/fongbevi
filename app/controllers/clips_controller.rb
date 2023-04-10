class ClipsController < AuthController
  protect_from_forgery with: :null_session
  #wrap_parameters format: []
  #rescue_from ActionController::UnpermittedParameters, with: :render_unpermitted_params_response

  before_action :set_clip, only: %i[ show edit update destroy ]

  # GET /clips or /clips.json
  def index
    @clips = Clip.all
    
    respond_to do |format|
      format.html
      format.csv { send_data Clip.to_csv, filename: "clips-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
    end
  end

  # GET /clips/1 or /clips/1.json
  def show
  end

  # GET /clips/new
  def new
    sentences = Sentence.where(has_clip: false)
    #user_sentences = current_user.sentences   
    
   
    #sentences = sentences.without(user_sentences)
    random_offset = rand(sentences.count)
    @sentence = sentences.offset(random_offset).first
    @clip = Clip.new
  end

  # GET /clips/1/edit
  def edit
  end

  # POST /clips or /clips.json
  def create
    user = User.find(clip_params["user_id"])
    @clip = Clip.new(clip_params.merge(user: user))

    # Initialize AWS SDK for Ruby
    s3 = Aws::S3::Resource.new(
      access_key_id: Rails.application.credentials.aws[:access_key_id],
      secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'us-west-2'
    )
  
    if params[:clip][:audio].present?
      # Generate a unique file name
      file_name = clip_params["audio"].original_filename
  
      # Set the S3 object key using the custom file name
      s3_object_key = "uploads/#{file_name}"
  
      # Upload the file to S3 with the custom file name and content type
      s3.bucket('fongbevi').object(s3_object_key).upload_file(
        params[:clip][:audio].tempfile.path,
        content_type: params[:clip][:audio].content_type
      )

    end
  
    respond_to do |format|
      if @clip.save
        sentence_id = @clip.sentence_id
        UserSentence.create(user: current_user, sentence_id: sentence_id)
        Sentence.find(sentence_id).update(has_clip: true)
        format.html { redirect_to new_clip_url, notice: "Clip was successfully updated." }
        format.json { render :show, status: :created, location: @clip }
      else
        format.html { render :new, status: :unprocessable_entity }
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
