require 'rails_helper'

describe Curupira::PermissionsController do
  let(:user) { FactoryGirl.create :user }

  before do
    login_user(user)
  end

  describe "POST create" do
    let(:group)   { FactoryGirl.create :group }
    let!(:group_user)   { FactoryGirl.create :group_user, user: user, group: group }
    let!(:role) { FactoryGirl.create :role }

    let(:params)  do
      { 
        role_group_users_attributes: {
          "0": {
            role_id: role.id,
            group_user_id: group_user.id,
            _destroy: true 
          }
        } 
      } 
    end

    before do
      patch :create, user_id: user, group_user_id: group_user, group_user: params
    end 

    it "sets flash message" do
      expect(flash[:notice]).to eql "Permissões atualizadas com sucesso"
    end

    it "redirects to user" do
      expect(response).to redirect_to users_path
    end

    it "updates user permissions" do
      expect(user.role_group_users).to_not be_empty
    end
  end
end