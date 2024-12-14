# frozen_string_literal: true

require 'csv'

module Administrate
  class ReservasController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_reserva, only: [:show, :edit, :update, :destroy]
    before_action :set_carros, only: [:new, :edit, :show]
    before_action :set_users, only: [:new, :edit, :show]
    before_action :generate_csv, only: [:new, :edit, :show]

    layout "administrate"

    # GET /reservas or /reservas.json
    def index
      @reservas = Reserva.includes(:carro, :user).page(params[:page]).per(10)
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
          format.html { redirect_to([:administrate, @reserva], notice: "Reserva was successfully created.") }
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
          format.html { redirect_to([:administrate, @reserva], notice: "Reserva was successfully updated.") }
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
        format.html { redirect_to administrate_reservas_path, status: :see_other, notice: "Reserva foi cancelada com sucesso." }
        format.json { head :no_content }
      rescue => e
        format.html { redirect_to administrate_reservas_path, alert: "Erro ao cancelar a reserva: #{e.message}" }
        format.json { render json: { error: e.message }, status: :unprocessable_entity }
      end
    end



  def export_csv
    @reservas = Reserva.includes(:carro, :user).order(:id)
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["ID", "Cliente", "Carro", "Data de Início", "Data de Fim", "Status"]

      @reservas.each do |reserva|
        csv << [
          reserva.id,
          reserva.user.nome,
          reserva.carro.modelo,
          reserva.data_inicio.strftime('%d/%m/%Y'),
          reserva.data_fim.strftime('%d/%m/%Y'),
          reserva.status
        ]
      end
    end

    respond_to do |format|
      format.csv { send_data csv_data, filename: "reservas-#{Date.today}.csv" }
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
end
