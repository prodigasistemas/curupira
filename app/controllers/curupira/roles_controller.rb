class Curupira::RolesController < Curupira::AuthorizedController
  def index
    @roles = Role.all
  end

  def show
    @role = Role.find params[:id]
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find params[:id]
  end

  def create
    @role = Role.new role_params
    
    if @role.save
      redirect_to @role, notice: "Perfil criado com sucesso"
    else
      render :new
    end
  end

  def update
    @role = Role.find params[:id]

    if @role.update(role_params)
      redirect_to @role, notice: "Perfil atualizado com sucesso"
    else
      render :edit
    end
  end

  private

  def role_params
    params.require(:role).permit(:name, :active, authorizations_attributes: [:id, :feature_id, :_destroy])
  end
end