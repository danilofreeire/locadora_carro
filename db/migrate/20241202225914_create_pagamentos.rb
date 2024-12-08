# frozen_string_literal: true

class CreatePagamentos < ActiveRecord::Migration[7.1]
  def change
    create_table(:pagamentos) do |t|
      t.references(:reserva, null: false, foreign_key: true)
      t.decimal(:valor)
      t.string(:status)
      t.string(:metodo_pagamento)
      t.date(:data_pagamento)

      t.timestamps
    end
  end
end
