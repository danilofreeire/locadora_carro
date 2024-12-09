# frozen_string_literal: true

namespace :dev do
  desc "Reseta o banco de dados"
  task reset: :environment do
    system("rails db:drop")
    system("rails db:create")
    system("rails db:migrate")
    system("rails db:seed")
    system("rails dev:add_dados")
  end

  desc "Adiciona carros, clientes, reservas e pagamentos fake"
  task add_dados: :environment dor
    show_spinner("Adicionando Categorias...") { add_categorias }
    show_spinner("Adicionando Carros...") { add_carros }
    show_spinner("Adicionando Clientes...") { add_clientes }
    show_spinner("Adicionando Reservas...") { add_reservas }
    show_spinner("Adicionando Pagamentos...") { add_pagamentos }
  end

  def add_categorias
    categorias = ["Sedan", "Hatch", "SUV", "Caminhonete", "Esportivo", "Luxo"]
    categorias.each do |categoria|
      Categoria.find_or_create_by!(nome: categoria, descricao: "Categoria de veículos: #{categoria}")
    end
  end

  def add_carros
    categorias = Categoria.all
    20.times do
      Carro.create!(
        marca: Faker::Vehicle.manufacture,
        modelo: Faker::Vehicle.model,
        ano: Faker::Vehicle.year,
        cor: Faker::Vehicle.color,
        placa: Faker::Vehicle.license_plate,
        status: ["disponível", "alugado", "manutenção"].sample,
        diaria: Faker::Commerce.price(range: 50..300),
        categoria: categorias.sample, # Associa o carro a uma categoria aleatória
      )
    end
  end

  def add_clientes
    30.times do
      Cliente.create!(
        nome: Faker::Name.name,
        email: Faker::Internet.email,
        telefone: Faker::PhoneNumber.cell_phone,
        endereco: Faker::Address.full_address,
      )
    end
  end

  def add_reservas
    50.times do
      carro = Carro.where(status: "disponível").sample
      next unless carro # Garante que existe um carro disponível

      cliente = Cliente.all.sample
      data_inicio = Faker::Date.forward(days: rand(1..30))
      data_fim = data_inicio + rand(1..10).days
      preco_total = carro.diaria * (data_fim - data_inicio).to_i

      Reserva.create!(
        cliente_id: cliente.id,
        carro_id: carro.id,
        data_inicio: data_inicio,
        data_fim: data_fim,
        preco_total: preco_total,
        status: ["pendente", "pago", "atrasado"].sample,
      )

      # Atualiza o status do carro para "alugado"
      carro&.update!(status: "alugado")
    end
  end

  def add_pagamentos
    Reserva.all.find_each do |reserva|
    status = ["pendente", "pago", "atrasado"].sample
    data_pagamento = status == "pago" ? Faker::Date.backward(days: 10) : Faker::Date.forward(days: 5)
      Pagamento.create!(
        reserva_id: reserva.id,
        valor: reserva.preco_total,
        status: status,
        metodo_pagamento: ["cartão", "boleto", "pix", "dinheiro"].sample,
        data_pagamento: data_pagamento
        )
    end
  end

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
