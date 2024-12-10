class ReservasController < ApplicationController
    before_action :authenticate_user! #apenas usuários logados acessam
    
    def index
      @reservas = current_user.reservas.includes(:carro) #apenas as reservas do usuário logado
    end
end
  