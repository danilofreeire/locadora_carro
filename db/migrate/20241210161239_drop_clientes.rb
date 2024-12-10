# frozen_string_literal: true

class DropClientes < ActiveRecord::Migration[7.1]
  def change
    drop_table :clientes
  end
end
