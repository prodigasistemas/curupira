require "rails_helper"

describe Curupira::SessionsController do
  describe "GET new" do
    it "should get new" do
      get :new
      expect(response).to be_success
    end

    it "returns new user" do
      get :new
      expect(assigns(:user)).to be_new_record
    end

    context "when user is already logged in" do
      it "redirects to root path" do
        login_user(FactoryGirl.create :user)

        get :new
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eql "Você já está logado"
      end
    end
  end

  describe "POST create" do
    let(:user) { FactoryGirl.create :user, password: 123456 }

    context "when credentials are valid" do
      context "with email" do
        it "create session" do
          post :create, params: { user: { username: user.email, password: 123456 } }

          expect(User.find(session[:user_id])).to eql user
        end
      end

      context "with username" do
        it "create session" do
          post :create, params: { user: { username: user.username, password: 123456 } }

          expect(User.find(session[:user_id])).to eql user
        end
      end

      it "redirects to root path" do
        post :create, params: { user: { username: user.email, password: 123456 } }

        expect(response).to redirect_to root_path
      end

      it "renders flash notice" do
        post :create, params: { user: { username: user.email, password: 123456 } }

        expect(flash[:notice]).to eql "Bem vindo!"
      end

      context "when user is already logged in" do
        it "redirects to root path" do
          login_user(FactoryGirl.create :user)

          post :create, params: { user: { username: user.email, password: 123456 } }
          expect(response).to redirect_to root_path
          expect(flash[:alert]).to eql "Você já está logado"
        end
      end
    end

    context "when credentials are invalid" do
      it "renders flash alert" do
        post :create, params: { user: { username: user.email, password: "wrong pass" } }

        expect(flash[:alert]).to eql "Login ou senha inválidos"
      end

      it "renders new" do
        post :create, params: { user: { username: user.email, password: "wrong pass" } }

        expect(response).to render_template :new
      end

      it "returns new user" do
        post :create, params: { user: { username: user.email, password: "wrong pass" } }

        expect(assigns[:user]).to be_new_record
        expect(assigns[:user].username).to eql user.email
        expect(assigns[:user].password).to eql nil
      end
    end
  end


  describe "DELETE destroy" do
    let(:user) { FactoryGirl.create :user }

    it "deletes session" do
      login_user(user)

      expect(session[:user_id].to_i).to eql user.id
      delete :destroy
      expect(session[:user_id]).to eql nil
    end

    it "redirects to sign in path" do
      login_user(user)

      delete :destroy

      expect(response).to redirect_to new_session_path
    end
  end
end
