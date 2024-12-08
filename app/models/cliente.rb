# frozen_string_literal: true

class Cliente < ApplicationRecord
  has_many :reservas
end
