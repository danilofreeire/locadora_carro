# frozen_string_literal: true

json.array!(@clientes, partial: "clientes/cliente", as: :cliente)
