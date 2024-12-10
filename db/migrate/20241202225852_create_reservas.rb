# frozen_string_literal: true

class CreateReservas < ActiveRecord::Migration[7.1]
  def change
    create_table(:reservas) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.references(:carro, null: false, foreign_key: true)
      t.date(:data_inicio)
      t.date(:data_fim)
      t.decimal(:preco_total)
      t.string(:status)

      t.timestamps
    end
  end
end
