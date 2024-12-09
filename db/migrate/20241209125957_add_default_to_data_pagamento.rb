# frozen_string_literal: true

class AddDefaultToDataPagamento < ActiveRecord::Migration[7.1]
  def change
    change_column_default :pagamentos, :data_pagamento, -> { 'CURRENT_TIMESTAMP' }
  end
end
