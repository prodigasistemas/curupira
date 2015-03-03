class Curupira::GroupsController < Curupira::AuthorizedController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: "Grupo criado com sucesso"
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])

    if @group.update group_params
      redirect_to @group, notice: "Grupo atualizado com sucesso"
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :active, role_groups_attributes: [:id, :role_id, :_destroy])
  end
end
