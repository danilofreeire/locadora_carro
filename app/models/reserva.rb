# frozen_string_literal: true

class Reserva < ApplicationRecord
  belongs_to :cliente
  belongs_to :carro
end
