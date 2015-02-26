class Curupira::UserGroupsController < Curupira::AuthorizedController
  def index
    @groups = UserGroup.all
  end

  def show
    @group = UserGroup.find(params[:id])
  end

  def new
    @group = UserGroup.new
  end

  def edit
    @group = UserGroup.find(params[:id])
  end

  def create
    @group = UserGroup.new(group_params)

    if @group.save
      redirect_to @group, notice: "Grupo criado com sucesso"
    else
      render :new
    end
  end

  def update
    @group = UserGroup.find(params[:id])

    if @group.update group_params
      redirect_to @group, notice: "Grupo atualizado com sucesso"
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:user_group).permit(:name, :active)
  end
end
