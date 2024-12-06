# frozen_string_literal: true

json.array!(@pagamentos, partial: "pagamentos/pagamento", as: :pagamento)
