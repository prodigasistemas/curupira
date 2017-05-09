require 'rails_helper'

describe Curupira::RolesController  do
  let(:user) { FactoryGirl.create :user }

  before do
    login_user(user)
  end

  describe "GET index" do
    let!(:roles) { FactoryGirl.create_list(:role, 2) }

    before do
      get :index
    end

    it { expect(response).to be_success }

    it { expect(assigns(:roles).count).to eql 2 }
  end

  describe "GET show" do
    context "when role exists" do
      let!(:role) { FactoryGirl.create(:role) }

      it "should get show" do
        get :show, params: { id: role }
        expect(response).to be_success
      end

      it "returns role" do
        get :show, params: { id: user }
        expect(assigns(:role)).to eql role
      end
    end

    context "when user does not exist" do
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

    it "returns new role" do
      get :new
      expect(assigns(:role)).to be_new_record
    end
  end

  describe "GET edit" do
    context "when role exists" do
      let!(:role) { FactoryGirl.create(:role) }

      it "should get edit" do
        get :edit, params: { id: role }
        expect(response).to be_success
      end

      it "returns role" do
        get :edit, params: { id: role }
        expect(assigns(:role)).to eql role
      end
    end

    context "when user does not exist" do
      it "renders 404" do
        expect {
          get :edit, params: { id: "wrong id" }
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST create" do
    context "when role is valid" do
      let!(:feature) { FactoryGirl.create(:feature, name: "Cadastrar") }
      let(:params) do
        {
          name: "Minha Role",
          authorizations_attributes: {
            "0": {
              feature_id: feature.id
            }
          }
        }
      end

      it "should redirect to new user" do
        post :create, params: { role: params }
        expect(flash[:notice]).to eql "Perfil criado com sucesso"
      end

      it "should redirect to new role" do
        post :create, params: { role: params }
        expect(response).to redirect_to assigns(:role)
      end

      it "creates role" do
        expect {
          post :create, params: { role: params }
        }.to change { Role.count }.by(1)

        expect(assigns[:role].name).to eql "Minha Role"
        expect(assigns[:role].features.first.name).to eq("Cadastrar")
      end
    end

    context "when role is invalid" do
      let(:params) { FactoryGirl.build(:role, name: '').attributes }

      it "does not create user" do
        expect {
          post :create, params: { role: params }
        }.to change { Role.count }.by(0)
      end

      it "should render new" do
        post :create, params: { role: params }
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    let!(:role) { FactoryGirl.create(:role, name: 'Minha role') }

    context "when user is valid" do
      let(:params) { FactoryGirl.build(:role, name: 'Outra role').attributes }

      it "sets flash message" do
        put :update, params: { id: role, role: params }
        expect(flash[:notice]).to eql "Perfil atualizado com sucesso"
      end

      it "redirects to user" do
        put :update, params: { id: role, role: params }
        expect(response).to redirect_to assigns(:role)
      end

      it "updates role" do
        put :update, params: { id: role, role: params }
        expect(assigns(:role).name).to eql "Outra role"
      end
    end

    context "when role is invalid" do
      let(:params) { FactoryGirl.build(:role, name: '').attributes }

      it "does not create role" do
        put :update, params: { id: role, role: params }
        expect(assigns(:role).reload.name).to eql role.name
      end

      it "should render edit" do
        put :update, params: { id: role, role: params }
        expect(response).to render_template :edit
      end
    end
  end
end