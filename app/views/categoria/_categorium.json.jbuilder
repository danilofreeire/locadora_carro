# frozen_string_literal: true

json.extract!(categorium, :id, :nome, :descricao, :created_at, :updated_at)
json.url(categorium_url(categorium, format: :json))
