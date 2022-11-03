class Admin::SentencesController < AuthController
  before_action :set_sentence, only: %i[ show edit update destroy ]

  # GET /sentences or /sentences.json
  def index
    @sentences = Sentence.all
  end

  # GET /sentences/1 or /sentences/1.json
  def show
  end

  # GET /sentences/new
  def new
    @sentence = Sentence.new
  end

  # GET /sentences/1/edit
  def edit
  end

  # POST /sentences or /sentences.json
  def create
    @sentence = Sentence.new(sentence_params)

    respond_to do |format|
      if @sentence.save
        format.html { redirect_to admin_sentence_url(@sentence), notice: "Sentence was successfully created." }
        format.json { render :show, status: :created, location: @sentence }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sentences/1 or /sentences/1.json
  def update
    respond_to do |format|
      if @sentence.update(sentence_params)
        format.html { redirect_to sentence_url(@sentence), notice: "Sentence was successfully updated." }
        format.json { render :show, status: :ok, location: @sentence }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sentences/1 or /sentences/1.json
  def destroy
    @sentence.destroy

    respond_to do |format|
      format.html { redirect_to admin_sentences_url, notice: "Sentence was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sentence
      @sentence = Sentence.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sentence_params
      params.require(:sentence).permit(:content, :is_used, :clips_count, :has_valid_clips,:audio)
    end
end
