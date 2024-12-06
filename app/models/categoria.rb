# frozen_string_literal: true

class Categoria < ApplicationRecord
  self.table_name = "categoria" # Nome singular da tabela no banco
  has_many :carros, dependent: :destroy

end
