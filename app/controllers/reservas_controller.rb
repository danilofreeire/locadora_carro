class ReservasController < ApplicationController
  before_action :authenticate_user!




  def index
    @reservas = current_user.reservas.includes(:carro)
  end

  def show
    @reserva = Reserva.find(params[:id])
  end

  def new
    @reserva = Reserva.new
    @carro = Carro.find(params[:carro_id]) if params[:carro_id]
    @reserva.carro = @carro if @carro
    @reserva.user = current_user
    @reserva.preco_total = @carro.diaria if @carro
  end

  def create
    @reserva = Reserva.new(reserva_params)
    @reserva.user = current_user

    if @reserva.data_inicio.present? && @reserva.data_fim.present?
      @reserva.preco_total = calcular_preco_total(@reserva)
    end

    respond_to do |format|
      if @reserva.save
        format.html { redirect_to reservas_path, notice: "Reserva efetuada com sucesso." }
        format.json { render :show, status: :created, location: @reserva }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @reserva = Reserva.find(params[:id])
  end

  def update
    @reserva = Reserva.find(params[:id])
    if @reserva.data_inicio.present? && @reserva.data_fim.present?
      @reserva.preco_total = calcular_preco_total(@reserva)
    end
    respond_to do |format|
      if @reserva.update(reserva_params)
        format.html { redirect_to reservas_path, notice: "Reserva foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @reserva }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reserva = Reserva.find(params[:id])
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @reserva.destroy!
        @reserva.carro.update!(status: "Disponível") if @reserva.carro.present?
      end
      format.html { redirect_to reservas_path, notice: "Reserva foi cancelada com sucesso." }
      format.json { head :no_content }
    rescue => e
      format.html { redirect_to reservas_path, alert: "Erro ao cancelar a reserva: #{e.message}" }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end

  private

  def calcular_preco_total(reserva)
    dias = (reserva.data_fim - reserva.data_inicio).to_i + 1
    dias * reserva.carro.diaria
  end

  def reserva_params
    params.require(:reserva).permit(:user_id, :carro_id, :data_inicio, :data_fim, :preco_total, :status)
  end
end
