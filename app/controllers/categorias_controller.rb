class CategoriasController < ApplicationController

  
  def show
    @categoria = Categoria.find(params[:id]) 
    @carros = @categoria.carros
  end#
  

end

