require "rails_helper"

describe Curupira::UsersController do
  let(:user) { FactoryGirl.create :user }

  before do
    login_user(user)
  end

  describe "GET index" do
    let!(:group) { FactoryGirl.create(:group, users: [user, FactoryGirl.create(:user)]) }

    it "should get index" do
      get :index
      expect(response).to be_success
    end

    it "returns all users" do
      get :index
      expect(assigns(:users).count).to eql 2
    end
  end

  describe "GET show" do
    context "when user exists" do
      it "should get show" do
        get :show, params: { id: user }
        expect(response).to be_success
      end

      it "returns user" do
        get :show, params: { id: user }
        expect(assigns(:user)).to eql user
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

    it "returns new user" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end

  describe "GET edit" do
    context "when user exists" do
      it "should get edit" do
        get :edit, params: { id: user }
        expect(response).to be_success
      end

      it "returns user" do
        get :edit, params: { id: user }
        expect(assigns(:user)).to eql user
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
    context "when user is valid" do
      let(:group) { FactoryGirl.create :group, name: "Apple Corp" }
      let(:role) { FactoryGirl.create :role, name: 'Minha Role' }
      let(:params) { { email: "new_email@mail.com",
                        username: "new_username",
                        name: "New Name",
                        password: 12345678,
                        group_users_attributes: { "0": { group_id: group.id, role_group_users_attributes: { "0": { role_id: role.id } } } } } }

      it "should redirect to new user" do
        post :create, params: { user: params }
        expect(flash[:notice]).to eql "Usuário criado com sucesso"
      end

      it "should redirect to new user" do
        post :create, params: { user: params }
        expect(response).to redirect_to assigns(:user)
      end

      it "creates user" do
        expect {
          post :create, params: { user: params }
        }.to change { User.count }.by(1)

        expect(assigns[:user].email).to eql "new_email@mail.com"
        expect(assigns[:user].username).to eql "new_username"
        expect(assigns[:user].name).to eql "New Name"
        expect(assigns[:user].groups.first.name).to eql "Apple Corp"
        expect(assigns[:user].role_group_users.first.role.name).to eql "Minha Role"
      end
    end

    context "when user is invalid" do
      let(:params)  { { username: "new_username",
                        name: "New Name",
                        password: 12345678 } }

      it "does not create user" do
        expect {
          post :create, params: { user: params }
        }.to change { User.count }.by(0)
      end

      it "should render new" do
        post :create, params: { user: params }
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    context "when user is valid" do
      let(:group)   { FactoryGirl.create :group }
      let!(:group_user)   { FactoryGirl.create :group_user, user: user, group: group }

      let(:params)  { { email: "new_email@mail.com",
                        username: "new_username",
                        name: "New Name",
                        password: 12345678,
                        group_users_attributes: { "0": { id: group.id, _destroy: true } } } }

      it "sets flash message" do
        put :update, params: { id: user, user: params }
        expect(flash[:notice]).to eql "Usuário atualizado com sucesso"
      end

      it "redirects to user" do
        put :update, params: { id: user, user: params }
        expect(response).to redirect_to assigns(:user)
      end

      it "updates user" do
        expect(user.groups).to_not    be_empty

        put :update, params: { id: user, user: params }
        expect(assigns(:user).email).to    eql "new_email@mail.com"
        expect(assigns(:user).username).to eql "new_username"
        expect(assigns(:user).name).to     eql "New Name"
        expect(user.groups).to        be_empty
      end
    end

    context "when user is invalid" do
      let(:params)  { { email: "",
                        username: "new_username",
                        name: "New Name",
                        password: 12345678 } }

      it "does not create user" do
        put :update, params: { id: user, user: params }
        expect(assigns(:user).reload.email).to    eql user.email
        expect(assigns(:user).reload.username).to eql user.username
        expect(assigns(:user).reload.name).to     eql user.name
      end

      it "should render edit" do
        put :update, params: { id: user, user: params }
        expect(response).to render_template :edit
      end
    end
  end
end
