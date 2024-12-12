class ReservasController < ApplicationController
    before_action :authenticate_user! #apenas usuários logados acessam
    layout "reservas"
    
    def index
      @reservas = current_user.reservas.includes(:carro) #apenas as reservas do usuário logado
    end

    # GET /reservas/1 or /reservas/1.json
    def show
    end

    # GET /reservas/new
    def new
      @reserva = Reserva.new
    end

    # GET /reservas/1/edit
    def edit
    end

    # POST /reservas or /reservas.json
    def create
      @reserva = Reserva.new(reserva_params)

      respond_to do |format|
        if @reserva.save
          format.html { redirect_to( @reserva, notice: "Reserva was successfully created.") }
          format.json { render(:show, status: :created, location: @reserva) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @reserva.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /reservas/1 or /reservas/1.json
    def update
      respond_to do |format|
        if @reserva.update(reserva_params)
          format.html { redirect_to( @reserva, notice: "Reserva was successfully updated.") }
          format.json { render(:show, status: :ok, location: @reserva) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @reserva.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /reservas/1 or /reservas/1.json
    def destroy
      respond_to do |format|
        ActiveRecord::Base.transaction do
          @reserva.destroy!
          @reserva.carro.update!(status: "Disponível") if @reserva.carro.present? # Torna o carro disponível novamente
        end
        format.html { redirect_to reservas_path, status: :see_other, notice: "Reserva foi cancelada com sucesso." }
        format.json { head :no_content }
      rescue => e
        format.html { redirect_to reservas_path, alert: "Erro ao cancelar a reserva: #{e.message}" }
        format.json { render json: { error: e.message }, status: :unprocessable_entity }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_reserva
      @reserva = Reserva.find(params[:id])
    end
    def set_users
      @users = User.all
    end

    def set_carros
      @carros = Carro.where(status: "Disponível")
    end
    

    # Only allow a list of trusted parameters through.
    def reserva_params
      params.require(:reserva).permit(:user_id, :carro_id, :data_inicio, :data_fim, :preco_total, :status)
    end


end

  