# frozen_string_literal: true
require 'csv'

module Administrate
  class UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    layout "administrate"

    # GET /users or /users.json
    def index
      @users = User.page(params[:page]).per(10)
    end

    # GET /users/1 or /users/1.json
    def show
    end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users or /users.json
    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to([:administrate, @user], notice: "user was successfully created.") }
          format.json { render(:show, status: :created, location: @user) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @user.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to([:administrate, @user], notice: "user was successfully updated.") }
          format.json { render(:show, status: :ok, location: @user) }
        else
          format.html { render(:edit, status: :unprocessable_entity) }
          format.json { render(json: @user.errors, status: :unprocessable_entity) }
        end
      end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
      @user.destroy!

      respond_to do |format|
        format.html do
          redirect_to(administrate_users_path, status: :see_other, notice: "user was successfully destroyed.")
        end
        format.json { head(:no_content) }
      end
    end

    def export_csv
      @users = User.order(:id)
      csv_data = CSV.generate(headers: true) do |csv|
        csv << ["ID", "Nome", "Email", "Telefone", "Endereço"]
  
        @users.each do |user|
          csv << [
            user.id,
            user.nome,
            user.email,
            user.telefone,
            user.endereco
          ]
        end
      end
  
      respond_to do |format|
        format.csv { send_data csv_data, filename: "clientes-#{Date.today}.csv" }
      end
    end
  







    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      Rails.logger.debug("Parâmetro recebido: #{params[:id]}")
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:nome, :email, :telefone, :endereco, :password, :password_confirmation)
    end
  end
end
