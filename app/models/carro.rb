# frozen_string_literal: true

class Carro < ApplicationRecord
  belongs_to :categoria
  has_many :reservas
  validates :status, inclusion: { in: ["Disponível", "Alugado", "Manutenção"] }

  has_one_attached :cover_image do |attachable|
    attachable.variant(:thumb, resize_to_limit: [420, 227])
  end
end
