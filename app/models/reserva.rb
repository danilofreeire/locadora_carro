# frozen_string_literal: true

class Reserva < ApplicationRecord
  belongs_to :carro
  belongs_to :user
  has_one :pagamento, dependent: :destroy #qnd excluir uma reserva, exclui o pagamento tb

  validates :user, presence: true
  validates :carro, presence: true
  validates :data_inicio, presence: true
  validates :data_fim, presence: true #deve ser obrigatório
  validate :data_fim_deve_ser_maior_que_data_inicio

  private
  def data_fim_deve_ser_maior_que_data_inicio
    return if data_inicio.blank? || data_fim.blank?

    if data_fim <= data_inicio
      errors.add(:data_fim, "deve ser maior que a data de início")
    end
  end

  paginates_per 10
end
