# frozen_string_literal: true

json.extract!(
  reserva,
  :id,
  :user_id,
  :carro_id,
  :data_inicio,
  :data_fim,
  :preco_total,
  :status,
  :created_at,
  :updated_at,
)
json.url(reserva_url(reserva, format: :json))
