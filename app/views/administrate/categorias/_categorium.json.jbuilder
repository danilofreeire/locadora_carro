# frozen_string_literal: true

json.extract!(categoria, :id, :nome, :descricao, :created_at, :updated_at)
json.url(categoria_url(categoria, format: :json))
