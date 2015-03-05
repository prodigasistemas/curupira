require 'rails_helper'

class BaseController < ApplicationController
  before_filter :authorize
end

describe BaseController, type: :controller do
<<<<<<< HEAD
  let!(:current_user)   { FactoryGirl.create(:user) }
  let!(:group_a) { FactoryGirl.create(:group, name: "Group A") }
  let!(:role_a) { FactoryGirl.create(:role, name: "Role A") }
  let!(:feature_a) { FactoryGirl.create(:feature, description: "Feature A", controller: "base", action: "index") }
  let!(:authorization) { FactoryGirl.create(:authorization, role: role_a, feature: feature_a) }
  let!(:role_group) { FactoryGirl.create(:role_group, role: role_a, group: group_a) }
  let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: group_a) }
  let!(:permission) { FactoryGirl.create(:permission, role: role_a, group_user: group_user) }
=======
  let!(:current_user) { FactoryGirl.create(:user) }
  let!(:feature) { FactoryGirl.create(:feature, controller: "base", action: "index") }
  let!(:authorization) { FactoryGirl.create(:authorization, feature: feature) }
  let!(:role_group) { FactoryGirl.create(:role_group, role: authorization.role) }
  let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: role_group.group) }
>>>>>>> fix tests

  controller do
    def index
      @success = true
      render nothing: true
    end

    def new; end
  end

  before do
    login_user current_user
  end

  context "when user not have authorization" do
    it "redirect to root_path" do
      get :new
      expect(flash[:notice]).to eq "Sem autorização"
    end
  end

  context "when user have authorization" do
    it "user access the resource" do
      get :index
      expect(assigns(:success)).to be true
    end
  end 
end