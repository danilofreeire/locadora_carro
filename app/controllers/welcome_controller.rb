# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout "application"

  def index
    @categorias = Categoria.all
  end


    def set_return_to_reservas
      session[:user_return_to] = reservas_path # Define o caminho para redirecionar após o login
      redirect_to new_user_session_path
    end

  

  
end
