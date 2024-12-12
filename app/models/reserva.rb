# frozen_string_literal: true

class Reserva < ApplicationRecord
  belongs_to :carro
  belongs_to :user
  has_one :pagamento, dependent: :destroy #qnd excluir uma reserva, exclui o pagamento tb
  
  validates :user, presence: true
  validates :carro, presence: true
  validates :data_inicio, presence: true
  validates :data_fim, presence: true #deve ser obrigatório
  validates :status, inclusion: { in: ["Pendente", "Pago", "Atrasado"] }

  
  validate :data_fim_deve_ser_maior_que_data_inicio
  validate :carro_status, on: :create


  after_create :criar_pagamento
  after_create :criar_pagamento, :atualizar_status_carro

  private

  def carro_status
    return if carro.blank?

    unless carro.status=="Disponível"
      errors.add(:carro, "não está disponível para reserva")
    end
  end



  def atualizar_status_carro
    carro.update!(status: "Alugado")
  end

  def reverter_status_carro
    carro.update!(status: "Disponível")
  end


  def data_fim_deve_ser_maior_que_data_inicio
    return if data_inicio.blank? || data_fim.blank?

    if data_fim <= data_inicio
      errors.add(:data_fim, "deve ser maior que a data de início")
    end
  end

  def criar_pagamento
  
    pagamento = Pagamento.new(
      reserva: self,
      valor: preco_total,
      status: self.status,
      metodo_pagamento: "Pix", # Método de pagamento padrão
      data_pagamento: self.data_fim
    )

    unless pagamento.save
      Rails.logger.error "Erro ao criar pagamento para a reserva #{id}: #{pagamento.errors.full_messages.join(', ')}"
      raise ActiveRecord::Rollback
    end
  end

end