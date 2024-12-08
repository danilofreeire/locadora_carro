# frozen_string_literal: true

module Administrate
  class ClientesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_cliente, only: [:show, :edit, :update, :destroy]
    layout "administrate"

    # GET /clientes or /clientes.json
    def index
      @clientes = Cliente.page(params[:page]).per(10)
    end

    # GET /clientes/1 or /clientes/1.json
    def show
    end

    # GET /clientes/new
    def new
      @cliente = Cliente.new
    end

    # GET /clientes/1/edit
    def edit
    end

    # POST /clientes or /clientes.json
    def create
      @cliente = Cliente.new(cliente_params)

      respond_to do |format|
        if @cliente.save
          format.html { redirect_to([:administrate, @cliente], notice: "Cliente was successfully created.") }
          format.json { render(:show, status: :created, location: @cliente) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @cliente.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /clientes/1 or /clientes/1.json
    def update
      respond_to do |format|
        if @cliente.update(cliente_params)
          format.html { redirect_to([:administrate, @cliente], notice: "Cliente was successfully updated.") }
          format.json { render(:show, status: :ok, location: @cliente) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @cliente.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /clientes/1 or /clientes/1.json
    def destroy
      @cliente.destroy!

      respond_to do |format|
        format.html do
          redirect_to(administrate_clientes_path, status: :see_other, notice: "Cliente was successfully destroyed.")
        end
        format.json { head(:no_content) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      Rails.logger.debug("Parâmetro recebido: #{params[:id]}")

      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:nome, :email, :telefone, :endereco)
    end
  end
end
