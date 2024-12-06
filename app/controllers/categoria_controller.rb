# frozen_string_literal: true

class CategoriaController < ApplicationController
  before_action :set_categorium, only: [:show, :edit, :update, :destroy]

  # GET /categoria or /categoria.json
  def index
    @categoria = Categoria.all
  end

  # GET /categoria/1 or /categoria/1.json
  def show
  end

  # GET /categoria/new
  def new
    @categorium = Categoria.new
  end

  # GET /categoria/1/edit
  def edit
  end

  # POST /categoria or /categoria.json
  def create
    @categorium = Categoria.new(categorium_params)

    respond_to do |format|
      if @categorium.save
        format.html { redirect_to(@categorium, notice: "Categoria was successfully created.") }
        format.json { render(:show, status: :created, location: @categorium) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @categorium.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /categoria/1 or /categoria/1.json
  def update
    respond_to do |format|
      if @categorium.update(categorium_params)
        format.html { redirect_to(@categorium, notice: "Categoria was successfully updated.") }
        format.json { render(:show, status: :ok, location: @categorium) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @categorium.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /categoria/1 or /categoria/1.json
  def destroy
    @categorium.destroy!

    respond_to do |format|
      format.html do
        redirect_to(categoria_index_path, status: :see_other, notice: "Categoria was successfully destroyed.")
      end
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_categorium
    @categorium = Categoria.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def categorium_params
    params.require(:categorium).permit(:nome, :descricao)
  end
end
