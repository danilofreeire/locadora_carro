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
  task add_dados: :environment do
    show_spinner("Adicionando Categorias...") { add_categorias }
    show_spinner("Adicionando Carros...") { add_carros }
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
        status: ["Disponível", "Alugado", "Manutenção"].sample,
        diaria: Faker::Commerce.price(range: 50..300),
        categoria: categorias.sample, # Associa o carro a uma categoria aleatória
      )
    end
  end

  def add_reservas
    users = User.all # Busca os usuários criados no seed
    raise "Sem usuários disponíveis para criar reservas" if users.empty?
  
    50.times do
      carro = Carro.where(status: "Disponível").sample
      next unless carro # Garante que existe um carro disponível
  
      user = users.sample # Seleciona um usuário
      data_inicio = Faker::Date.forward(days: rand(1..30))
      data_fim = data_inicio + rand(1..10).days
      preco_total = carro.diaria * (data_fim - data_inicio).to_i
  
      Reserva.create!(
        user_id: user.id, # Associa o usuário à reserva
        carro_id: carro.id,
        data_inicio: data_inicio,
        data_fim: data_fim,
        preco_total: preco_total,
        status: ["Pendente", "Pago", "Atrasado"].sample,
      )
  
      # Atualiza o status do carro para "alugado"
      carro&.update!(status: "Alugado")
    end
  end
  
  def add_pagamentos
    Reserva.all.find_each do |reserva|
    status = ["Pendente", "Pago", "Atrasado"].sample
    data_pagamento = status == "Pago" ? Faker::Date.backward(days: 10) : Faker::Date.forward(days: 5)
      Pagamento.create!(
        reserva_id: reserva.id,
        valor: reserva.preco_total,
        status: status,
        metodo_pagamento: ["Cartão", "Boleto", "Pix", "Dinheiro"].sample,
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
