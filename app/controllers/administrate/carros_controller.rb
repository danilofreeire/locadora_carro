# frozen_string_literal: true
module Administrate
  class CarrosController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_carro, only: [:show, :edit, :update, :destroy]
    
    # GET /carros or /carros.json
    def index
      if params[:categoria_id] # Filtra por categoria se o parâmetro for fornecido
        @categoria = Categoria.find_by(id: params[:categoria_id])
        @carros = @categoria&.carros || [] # Retorna os carros da categoria ou vazio se não existir
      else
        @carros = Carro.all
      end
    end

    # GET /carros/1 or /carros/1.json
    def show
    end

    # GET /carros/new
    def new
      @carro = Carro.new
    end

    # GET /carros/1/edit
    def edit
    end

    # POST /carros or /carros.json
    def create
      @carro = Carro.new(carro_params)

      respond_to do |format|
        if @carro.save
          format.html { redirect_to(@carro, notice: "Carro was successfully created.") }
          format.json { render(:show, status: :created, location: @carro) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @carro.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /carros/1 or /carros/1.json
    def update
      respond_to do |format|
        if @carro.update(carro_params)
          format.html { redirect_to(@carro, notice: "Carro was successfully updated.") }
          format.json { render(:show, status: :ok, location: @carro) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @carro.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /carros/1 or /carros/1.json
    def destroy
      @carro.destroy!

      respond_to do |format|
        format.html { redirect_to( administrate_carros_path, status: :see_other, notice: "Carro was successfully destroyed.") }
        format.json { head(:no_content) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_carro
      @carro = Carro.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def carro_params
      params.require(:carro).permit(:marca, :modelo, :ano, :cor, :placa, :status, :diaria)
    end
  end
end