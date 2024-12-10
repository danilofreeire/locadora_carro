# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

admins ={
"admin@admin.com"=> "Administrador", 
"test@test.com"=> "Teste",
}

admins.each do |email, nome|
  next if Admin.find_by(email: email)

  Admin.create!(
    email:,
    nome:,
    password: ENV["DEFAULT_PASSWORD"],
    password_confirmation: ENV["DEFAULT_PASSWORD"],
  )
  
end
30.times do
  User.create!(
    nome: Faker::Name.name,
    email: Faker::Internet.email,
    telefone: Faker::PhoneNumber.cell_phone,
    endereco: Faker::Address.full_address,
    password: "123456", # Senha padrão
    password_confirmation: "123456"
  )
end