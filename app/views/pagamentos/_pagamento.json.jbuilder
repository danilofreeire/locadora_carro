# frozen_string_literal: true

json.extract!(
  pagamento,
  :id,
  :reserva_id,
  :valor,
  :status,
  :metodo_pagamento,
  :data_pagamento,
  :created_at,
  :updated_at,
)
json.url(pagamento_url(pagamento, format: :json))
