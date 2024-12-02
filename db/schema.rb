# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_02_225914) do
  create_table "carros", force: :cascade do |t|
    t.string "marca"
    t.string "modelo"
    t.integer "ano"
    t.string "cor"
    t.string "placa"
    t.string "status"
    t.decimal "diaria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "telefone"
    t.string "endereco"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pagamentos", force: :cascade do |t|
    t.integer "reserva_id", null: false
    t.decimal "valor"
    t.string "status"
    t.string "metodo_pagamento"
    t.datetime "data_pagamento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reserva_id"], name: "index_pagamentos_on_reserva_id"
  end

  create_table "reservas", force: :cascade do |t|
    t.integer "cliente_id", null: false
    t.integer "carro_id", null: false
    t.date "data_inicio"
    t.date "data_fim"
    t.decimal "preco_total"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carro_id"], name: "index_reservas_on_carro_id"
    t.index ["cliente_id"], name: "index_reservas_on_cliente_id"
  end

  add_foreign_key "pagamentos", "reservas"
  add_foreign_key "reservas", "carros"
  add_foreign_key "reservas", "clientes"
end
