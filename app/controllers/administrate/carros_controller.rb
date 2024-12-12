# frozen_string_literal: true
require 'csv'

module Administrate
  class CarrosController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_carro, only: [:show, :edit, :update, :destroy, :destroy_cover_image]
    before_action :set_categorias, only: [:new, :edit, :show]

    layout "administrate"

    # GET /carros or /carros.json or /carros.csv
    def index
      @carros = Carro.includes(:categoria).page(params[:page]).per(10)

      respond_to do |format|
        format.html 
        format.csv do
          bom = "\uFEFF" 
          csv_data = CSV.generate(col_sep: ";", headers: true) do |csv|
            
            csv << ["ID", "Marca", "Modelo", "Ano", "Cor", "Placa", "Categoria"]
            
            
            @carros.each do |carro|
              csv << [
                carro.id,
                carro.marca,
                carro.modelo,
                carro.ano,
                carro.cor,
                carro.placa,
                carro.categoria&.nome
              ]
            end
          end
          send_data bom + csv_data, filename: "carros-#{Date.today}.csv", type: "text/csv"
        end
      end
    end

    def gerar_pdf
      @carros = Carro.all

      pdf = Prawn::Document.new
      pdf.text "Lista de Carros", size: 20, style: :bold
      pdf.move_down 20

      @carros.each do |carro|
        pdf.text "Marca: #{carro.marca}"
        pdf.text "Modelo: #{carro.modelo}"
        pdf.text "Ano: #{carro.ano}"
        pdf.text "Cor: #{carro.cor}"
        pdf.text "Placa: #{carro.placa}"
        pdf.text "Categoria: #{carro.categoria.nome}" if carro.categoria.present?
        pdf.move_down 10
      end

      send_data pdf.render, filename: "carros.pdf", type: "application/pdf", disposition: "inline"
    end

    def destroy_cover_image
      @carro.cover_image.purge
      respond_to do |format|
        format.turbo_stream { render(turbo_stream: turbo_stream.remove(@carro)) }
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
      @carro.cover_image.attach(carro_params[:cover_image])

      respond_to do |format|
        if @carro.save
          format.html { redirect_to([:administrate, @carro], notice: "Carro was successfully created.") }
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
          format.html { redirect_to([:administrate, @carro], notice: "Carro was successfully updated.") }
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
        format.html do
          redirect_to(administrate_carros_path, status: :see_other, notice: "Carro was successfully destroyed.")
        end
        format.json { head(:no_content) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_carro
      @carro = Carro.find(params[:id])
    end

    def set_categorias
      @categorias = Categoria.all
    end

    # Only allow a list of trusted parameters through.
    def carro_params
      params.require(:carro).permit(:marca, :modelo, :ano, :cor, :placa, :status, :diaria, :categoria_id, :cover_image)
    end
  end
end
