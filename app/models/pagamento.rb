# frozen_string_literal: true

class Pagamento < ApplicationRecord
  belongs_to :reserva
  
  validates :data_pagamento, presence: true
  validates :reserva, presence: true
  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ["Pendente", "Pago", "Atrasado"] }
  validates :metodo_pagamento, inclusion: { in: ["Cartão", "Boleto", "Pix", "Dinheiro"], allow_nil: true }


  before_validation :set_data_pagamento_default, on: :create


  private

  def set_data_pagamento_default
    self.data_pagamento ||= Date.today
  end

  paginates_per 10
end
