# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout 'application'

  def index
    @carros = Carro.all.order(updated_at:
    :desc).limit(6)
  end
end

