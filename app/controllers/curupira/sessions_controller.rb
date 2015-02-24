class Curupira::SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:username], params[:user][:password])

    if @user
      redirect_back_or_to(root_path, notice: 'Bem vindo!')
    else
      @user = User.new username: params[:user][:username]
      flash[:alert] = "Login ou senha inválidos"
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_path
  end
end
