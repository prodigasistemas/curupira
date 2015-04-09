class Curupira::PermissionsController < Curupira::AuthorizedController
  def create
    @group_user = GroupUser.find(params[:group_user_id])

    if @group_user.update(permissions_params)
      redirect_to users_path, notice: "Permissões atualizadas com sucesso"
    else
      render :show
    end
  end

  private

  def permissions_params
    params.require(:group_user).permit(
      role_group_users_attributes:[:id, :role_id, :group_user_id]
    )
  end
end