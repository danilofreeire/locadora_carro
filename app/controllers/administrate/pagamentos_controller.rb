# frozen_string_literal: true

module Administrate
  class PagamentosController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_pagamento, only: [:show, :edit, :update, :destroy]
    before_action :set_reservas, only: [:new, :edit, :show]

    layout "administrate"

    # GET /pagamentos or /pagamentos.json
    def index
      @pagamentos = Pagamento.includes(reserva: :user).page(params[:page]).per(10)
    end

    # GET /pagamentos/1 or /pagamentos/1.json
    def show
    end

    # GET /pagamentos/new
    def new
      @pagamento = Pagamento.new
    end

    # GET /pagamentos/1/edit
    def edit
    end

    # POST /pagamentos or /pagamentos.json
    def create
      @pagamento = Pagamento.new(pagamento_params)

      respond_to do |format|
        if @pagamento.save
          format.html { redirect_to([:administrate, @pagamento], notice: "Pagamento was successfully created.") }
          format.json { render(:show, status: :created, location: @pagamento) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @pagamento.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /pagamentos/1 or /pagamentos/1.json
    def update
      respond_to do |format|
        if @pagamento.update(pagamento_params)
          format.html { redirect_to([:administrate, @pagamento], notice: "Pagamento was successfully updated.") }
          format.json { render(:show, status: :ok, location: @pagamento) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @pagamento.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /pagamentos/1 or /pagamentos/1.json
    def destroy
      @pagamento.destroy!

      respond_to do |format|
        format.html do
          redirect_to(administrate_pagamentos_path, status: :see_other, notice: "Pagamento was successfully destroyed.")
        end
        format.json { head(:no_content) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_pagamento
      @pagamento = Pagamento.find(params[:id])
    end

    def set_reservas
      @reservas = Reserva.all
    end
    # Only allow a list of trusted parameters through.
    def pagamento_params
      params.require(:pagamento).permit(:reserva_id, :valor, :status, :metodo_pagamento, :data_pagamento)
    end
  end
end
