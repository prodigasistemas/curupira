require "rails_helper"

describe Curupira::GroupsController do
  let(:user) { FactoryGirl.create :user }

  before do
    login_user(user)
  end

  describe "GET index" do
    before do
      FactoryGirl.create :group
      FactoryGirl.create :group
    end

    it "should get index" do
      get :index
      expect(response).to be_success
    end

    it "returns all groups" do
      get :index
      expect(assigns(:groups).count).to eql 2
    end
  end

  describe "GET show" do
    let(:group) { FactoryGirl.create :group }

    context "when group exists" do
      it "should get show" do
        get :show, params: { id: group }
        expect(response).to be_success
      end

      it "returns group" do
        get :show, params: { id: group }
        expect(assigns(:group)).to eql group
      end
    end

    context "when group does not exist" do
      it "renders 404" do
        expect {
          get :show, params: { id: "wrong id" }
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "GET new" do
    it "should get new" do
      get :new
      expect(response).to be_success
    end

    it "returns new group" do
      get :new
      expect(assigns(:group)).to be_new_record
    end
  end

  describe "GET edit" do
    let(:group) { FactoryGirl.create :group }

    context "when group exists" do
      it "should get edit" do
        get :edit, params: { id: group }
        expect(response).to be_success
      end

      it "returns group" do
        get :edit, params: { id: group }
        expect(assigns(:group)).to eql group
      end
    end

    context "when group does not exist" do
      it "renders 404" do
        expect {
          get :edit, params: { id: "wrong id" }
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST create" do
    context "when group is valid" do
      let(:params)  { { name: "Group Name", active: false } }

      it "should redirect to new group" do
        post :create, params: { group: params }
        expect(flash[:notice]).to eql "Grupo criado com sucesso"
      end

      it "should redirect to new group" do
        post :create, params: { group: params }
        expect(response).to redirect_to assigns(:group)
      end

      it "creates group" do
        expect {
          post :create, params: { group: params }
        }.to change { Group.count }.by(1)
      end
    end

    context "when group is invalid" do
      let(:params)  { { name: "" } }

      it "does not create group" do
        expect {
          post :create, params: { group: params }
        }.to change { Group.count }.by(0)
      end

      it "should render new" do
        post :create, params: { group: params }
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    let(:group) { FactoryGirl.create :group }

    context "when group is valid" do
      let(:params)  { { name: "New group name", active: false } }

      it "sets flash message" do
        put :update, params: { id: group, group: params }
        expect(flash[:notice]).to eql "Grupo atualizado com sucesso"
      end

      it "redirects to group" do
        put :update, params: { id: group, group: params }
        expect(response).to redirect_to assigns(:group)
      end

      it "updates group" do
        put :update, params: { id: group, group: params }
        expect(assigns(:group).name).to   eql "New group name"
        expect(assigns(:group).active).to eql false
      end
    end

    context "when group is invalid" do
      let(:params)  { { name: "", active: false } }

      it "does not create group" do
        put :update, params: { id: group, group: params }
        expect(assigns(:group).reload.name).to eql group.name
        expect(assigns(:group).active).to      eql true
      end

      it "should render edit" do
        put :update, params: { id: group, group: params }
        expect(response).to render_template :edit
      end
    end
  end
end
