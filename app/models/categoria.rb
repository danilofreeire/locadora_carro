# frozen_string_literal: true

class Categoria < ApplicationRecord
  has_many :carros, dependent: :destroy

end
