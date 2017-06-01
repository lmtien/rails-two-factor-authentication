class TfasController < ApplicationController
  before_action :set_tfa, only: [:show, :edit, :update, :destroy]

  # GET /tfas
  # GET /tfas.json
  def index
    # @tfas = Tfa.new(user_id: 1)
    # @tfas.tfa_password = "tien"
    # @tfas.save!
    # clqstcfmajhgbqmx
    
    @tfas = Tfa.all
    TfaMailer.tfa_confirmation("test").deliver_now
  end

  # GET /tfas/1
  # GET /tfas/1.json
  def show
  end

  # GET /tfas/new
  def new
    @tfa = Tfa.new
  end

  # GET /tfas/1/edit
  def edit
  end

  # POST /tfas
  # POST /tfas.json
  def create
    @tfa = Tfa.new(tfa_params)

    respond_to do |format|
      if @tfa.save
        format.html { redirect_to @tfa, notice: 'Tfa was successfully created.' }
        format.json { render :show, status: :created, location: @tfa }
      else
        format.html { render :new }
        format.json { render json: @tfa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tfas/1
  # PATCH/PUT /tfas/1.json
  def update
    respond_to do |format|
      if @tfa.update(tfa_params)
        format.html { redirect_to @tfa, notice: 'Tfa was successfully updated.' }
        format.json { render :show, status: :ok, location: @tfa }
      else
        format.html { render :edit }
        format.json { render json: @tfa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tfas/1
  # DELETE /tfas/1.json
  def destroy
    @tfa.destroy
    respond_to do |format|
      format.html { redirect_to tfas_url, notice: 'Tfa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tfa
      @tfa = Tfa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tfa_params
      params.require(:tfa).permit(:user_id, :tfa_password, :attepmted)
    end
end
