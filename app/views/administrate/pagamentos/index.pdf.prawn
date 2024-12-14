require 'prawn'

Prawn::Document.generate("pagamentos_lista.pdf", page_size: "A4", margin: 0) do |pdf|
  # Adicionando a imagem de fundo cobrindo toda a página
  background_path = Rails.root.join("app/assets/images/templatepdf.png")
  pdf.image background_path, at: [0, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height

  # Adicionando margem para texto e configurando a fonte
  pdf.bounding_box([20, pdf.bounds.top - 20], width: pdf.bounds.width - 40) do
    # Título estilizado
    pdf.move_down 100

    pdf.text "Lista de Pagamentos", align: :center, size: 12, style: :bold, color: "000000"

    # Espaçamento após o título
    pdf.move_down 30

    # Cabeçalho da tabela
    headers = ["ID", "Cliente", "Valor", "Status", "Metodo", "Data"]

    # Dados da tabela
    data = Pagamento.all.collect do |p|
      [p.id, 
      p.reserva.user.nome,
      "R$ #{'%.2f' % p.valor}",
      p.reserva.status, 
      p.metodo_pagamento,
      I18n.l(p.data_pagamento)]
    end
    
    # Estilizando e montando a tabela
    pdf.table([headers] + data, header: true, width: pdf.bounds.width) do |table|
      # Estilo do cabeçalho
      table.row(0).background_color = "46ad34"
      table.row(0).text_color = "FFFFFF"
      table.row(0).font_style = :bold
      table.row(0).align = :center

      # Estilo das células
      table.cells.padding = 8
      table.cells.borders = [:bottom]
      table.cells.border_width = 1
      table.cells.border_color = "cccccc"

      # Alinhamento
      table.column(0).align = :center # ID
      table.column(5).align = :right # Diária
    end

    # Footer no final da página
    pdf.move_down 30
    pdf.text "Gerado automaticamente pelo sistema Locafácil", size: 10, align: :center, color: "888888"
  end
end
