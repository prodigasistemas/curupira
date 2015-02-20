class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find params[:id]
  end

  def create
    @role = Role.new roles_params

    if @role.save
      redirect_to role_paths, notice: "Role created successfully"
    else
      render :new
    end
  end

  def update
    @role = Role.find params[:id]

    if @role.update(roles_params)
      redirect_to role_paths, notice: "Role updated successfully"
    else
      render :edit
    end
  end

  private

  def roles_params
    params.require(:role).permit(:name)
  end
end