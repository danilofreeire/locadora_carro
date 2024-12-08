# frozen_string_literal: true

module Administrate
  class CategoriasController < ApplicationController
    before_action :authenticate_admin!

    before_action :set_categoria, only: [:show, :edit, :update, :destroy]
    layout "administrate"

    # GET /categoria or /categoria.json
    def index
      @categorias = Categoria.page(params[:page]).per(10)
    end

    # GET /categoria/1 or /categoria/1.json
    def show
    end

    # GET /categoria/new
    def new
      @categoria = Categoria.new
    end

    # GET /categoria/1/edit
    def edit
    end

    # POST /categoria or /categoria.json
    def create
      @categoria = Categoria.new(categoria_params)

      respond_to do |format|
        if @categoria.save
          format.html { redirect_to([:administrate, @categoria], notice: "Categoria was successfully created.") }
          format.json { render(:show, status: :created, location: @categoria) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @categoria.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /categoria/1 or /categoria/1.json
    def update
      respond_to do |format|
        if @categoria.update(categoria_params)
          format.html { redirect_to([:administrate, @categoria], notice: "Categoria was successfully updated.") }
          format.json { render(:show, status: :ok, location: @categoria) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @categoria.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /categoria/1 or /categoria/1.json
    def destroy
      respond_to do |format|
        format.html do
          if @categoria.carros.count > 0
            redirect_to(
              administrate_categorias_path,
              notice: "Existem carros cadastrados nessa categorias. Não é possível apagar",
            )
          else
            @categoria.destroy!
            redirect_to(administrate_categorias_path, status: :see_other, notice: "Categoria foi apagada.")

          end
        end
        format.json { head(:no_content) }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def categoria_params
      params.require(:categoria).permit(:nome, :descricao)
    end
  end
end
