# frozen_string_literal: true

module ApplicationHelper
  def cover_image_fallback(carro)
    carro.cover_image.attached?  ?  carro.cover_image.variant(:thumb) : "carros/carro1.png"
  end

end
