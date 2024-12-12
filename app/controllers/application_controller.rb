# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?


  
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

    # Its important that the location is NOT stored if:
    # - The request method is not GET (non idempotent)
    # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
    #    infinite redirect loop.
    # - The request is an Ajax request as this can lead to very unexpected behaviour.
    # - The request is not a Turbo Frame request ([turbo-rails](https://github.com/hotwired/turbo-rails/blob/main/app/controllers/turbo/frames/frame_request.rb))
  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !turbo_frame_request?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
  
  

  
  
  
    def after_sign_in_path_for(resource)
      stored_location = session[:user_return_to]
      session[:user_return_to] = nil # Limpa a variável de sessão
      stored_location || (resource.is_a?(Admin) ? administrate_path : reservas_path)
    end
  
  

  

  
  
    
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nome])
      devise_parameter_sanitizer.permit(:account_update, keys: [:nome])
    end

  
  
end

