# frozen_string_literal: true

class CreateClientes < ActiveRecord::Migration[7.1]
  def change
    create_table(:clientes) do |t|
      t.string(:nome)
      t.string(:email)
      t.string(:telefone)
      t.string(:endereco)

      t.timestamps
    end
  end
end
