# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout 'application'

  def index
    @categorias = Categoria.all
  end
end

