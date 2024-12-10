# frozen_string_literal: true

class AddClienteToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column(:users, :nome, :string)
    add_column(:users, :telefone, :string)
    add_column(:users, :endereco, :string)
  end
end
