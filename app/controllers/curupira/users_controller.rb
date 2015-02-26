class Curupira::UsersController < Curupira::AuthorizedController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "Usuário criado com sucesso"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update user_params
      redirect_to @user, notice: "Usuário atualizado com sucesso"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :username, :password, group_users_attributes: [:id, :group_id, :_destroy])
  end
end
