# frozen_string_literal: true

class CreateCarros < ActiveRecord::Migration[7.1]
  def change
    create_table(:carros) do |t|
      t.string(:marca)
      t.string(:modelo)
      t.integer(:ano)
      t.string(:cor)
      t.string(:placa)
      t.string(:status)
      t.decimal(:diaria)

      t.timestamps
    end
  end
end
