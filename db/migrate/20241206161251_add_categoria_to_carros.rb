# frozen_string_literal: true

class AddCategoriaToCarros < ActiveRecord::Migration[7.1]
  def change
    add_reference(:carros, :categoria, null: false, foreign_key: true)
  end
end
