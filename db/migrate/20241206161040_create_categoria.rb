# frozen_string_literal: true

class CreateCategoria < ActiveRecord::Migration[7.1]
  def change
    create_table(:categoria) do |t|
      t.string(:nome)
      t.text(:descricao)

      t.timestamps
    end
  end
end
