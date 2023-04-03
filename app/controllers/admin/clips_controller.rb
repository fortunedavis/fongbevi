class Admin::ClipsController < AuthController
  layout "admin"
  before_action :set_clip, only: %i[ show edit update destroy ]

  # GET /admin/clips or /admin/clips.json
  def index
    @clips = Clip.all
  end

  # GET /admin/clips/1 or /admin/clips/1.json
  def show
  end

  # GET /admin/clips/new
  def new
    @clip = Clip.new
  end

  # GET /admin/clips/1/edit
  def edit
  end

  def create
    @clip = Clip.new(clip_params)
    respond_to do |format|
      if @clip.save!
        format.html { redirect_to clip_url(@clip), notice: "Clip was successfully created." }
        format.json { render :show, status: :created, location: @clip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  def clipsvalidated
    votes = Vote.where(is_valid: true).pluck("clip_id")
    @clips = Clip.find(votes)
  end

  def clipsrejected
    votes = Vote.where(is_valid: false).pluck("clip_id")
    @clips = Clip.find(votes)
  end
  
  def clipswithoutvotes
    @clips = Clip.where(need_vote: true)
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

  # DELETE /admin/clips/1 or /admin/clips/1.json
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
      params.require(:clip).permit(:is_valid, :need_votes,:audio,:sentence_id)
    end
   

    def generate_csv(waves)
      CSV.generate(headers: true) do |csv|
        csv << ['Time', 'Height', 'Period', 'WAV']
        waves.each do |wave|
          csv << [wave.time, wave.height, wave.period, wave.id]
        end
      end
    end

end
