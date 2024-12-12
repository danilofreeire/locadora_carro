# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private
  def after_sign_in_path_for(resource)
    case resource
      
    when Admin
      administrate_path # Redireciona para o painel de admin
    when User
      reservas_path # Redireciona para a página de reservas dos usuários
    else
      root_path # Redireciona para a página inicial como fallback
    end
  end
    
end
