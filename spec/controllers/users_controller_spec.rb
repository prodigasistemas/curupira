require "rails_helper"

describe Curupira::UsersController do
  let(:user) { FactoryGirl.create :user }

  before do
    login_user(user)
  end

  describe "GET index" do
    before do
      FactoryGirl.create :user
    end

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
        get :show, id: user
        expect(response).to be_success
      end

      it "returns user" do
        get :show, id: user
        expect(assigns(:user)).to eql user
      end
    end

    context "when user does not exist" do
      it "renders 404" do
        expect {
          get :show, id: "wrong id"
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
        get :edit, id: user
        expect(response).to be_success
      end

      it "returns user" do
        get :edit, id: user
        expect(assigns(:user)).to eql user
      end
    end

    context "when user does not exist" do
      it "renders 404" do
        expect {
          get :edit, id: "wrong id"
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST create" do
    context "when user is valid" do
      let(:group)   { FactoryGirl.create :user_group, name: "Apple Corp" }
      let(:params)  { { email: "new_email@mail.com",
                        username: "new_username",
                        name: "New Name",
                        password: 12345678,
                        group_users_attributes: { "0": { user_group_id: group.id } } } }

      it "should redirect to new user" do
        post :create, user: params
        expect(flash[:notice]).to eql "Usuário criado com sucesso"
      end

      it "should redirect to new user" do
        post :create, user: params
        expect(response).to redirect_to assigns(:user)
      end

      it "creates user" do
        expect {
          post :create, user: params
        }.to change { User.count }.by(1)

        expect(assigns[:user].email).to eql "new_email@mail.com"
        expect(assigns[:user].username).to eql "new_username"
        expect(assigns[:user].name).to eql "New Name"
        expect(assigns[:user].user_groups.first.name).to eql "Apple Corp"
      end
    end

    context "when user is invalid" do
      let(:params)  { { username: "new_username",
                        name: "New Name",
                        password: 12345678 } }

      it "does not create user" do
        expect {
          post :create, user: params
        }.to change { User.count }.by(0)
      end

      it "should render new" do
        post :create, user: params
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT update" do
    context "when user is valid" do
      let(:group)   { FactoryGirl.create :user_group }
      let!(:group_user)   { FactoryGirl.create :group_user, user: user, user_group: group }

      let(:params)  { { email: "new_email@mail.com",
                        username: "new_username",
                        name: "New Name",
                        password: 12345678,
                        group_users_attributes: { "0": { id: group.id, _destroy: true } } } }

      it "sets flash message" do
        put :update, id: user, user: params
        expect(flash[:notice]).to eql "Usuário atualizado com sucesso"
      end

      it "redirects to user" do
        put :update, id: user, user: params
        expect(response).to redirect_to assigns(:user)
      end

      it "updates user" do
        expect(user.user_groups).to_not    be_empty

        put :update, id: user, user: params
        expect(assigns(:user).email).to    eql "new_email@mail.com"
        expect(assigns(:user).username).to eql "new_username"
        expect(assigns(:user).name).to     eql "New Name"
        expect(user.user_groups).to        be_empty
      end
    end

    context "when user is invalid" do
      let(:params)  { { email: "",
                        username: "new_username",
                        name: "New Name",
                        password: 12345678 } }

      it "does not create user" do
        put :update, id: user, user: params
        expect(assigns(:user).reload.email).to    eql user.email
        expect(assigns(:user).reload.username).to eql user.username
        expect(assigns(:user).reload.name).to     eql user.name
      end

      it "should render edit" do
        put :update, id: user, user: params
        expect(response).to render_template :edit
      end
    end
  end
end
