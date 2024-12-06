# frozen_string_literal: true

json.extract!(carro, :id, :marca, :modelo, :ano, :cor, :placa, :status, :diaria, :created_at, :updated_at)
json.url(carro_url(carro, format: :json))
