# frozen_string_literal: true

class Pagamento < ApplicationRecord
  belongs_to :reserva

  validates :reserva, presence: true
  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :data_pagamento, presence: true

  paginates_per 10
end
