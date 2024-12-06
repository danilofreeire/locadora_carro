# frozen_string_literal: true

json.array!(@reservas, partial: "reservas/reserva", as: :reserva)
