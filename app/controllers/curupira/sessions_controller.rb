class Curupira::SessionsController < ActionController::Base
  before_action :redirect_to_root_with_errors, if: :current_user, except: :destroy

  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:username], params[:user][:password])

    if @user
      redirect_to(root_path, notice: 'Bem vindo!')
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

  private

  def redirect_to_root_with_errors
    redirect_to root_path, alert: "Você já está logado"
  end
end
