require "rails_helper"

describe Curupira::PasswordsController do
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

  describe "GET edit" do
    context "when token exists" do
      let!(:user)  { FactoryGirl.create :user, reset_password_token: 123456 }

      it "should get new" do
        get :edit, params: { id: user.reset_password_token }
        expect(response).to be_success
      end

      it "returns user" do
        get :edit, params: { id: user.reset_password_token }
        expect(assigns(:user)).to eql user
      end
    end

    context "when token does not exists" do
      it "redirect to new_session_path" do
        get :edit, params: { id: "no token" }
        expect(response).to redirect_to :new_session
      end

      it "sends flash alert" do
        get :edit, params: { id: "no token" }
        expect(flash[:alert]).to eql "Token para resetar senha expirado ou inválido"
      end
    end

    context "when user is already logged in" do
      it "redirects to root path" do
        login_user(FactoryGirl.create :user)

        get :edit, params: { id: "any token here" }
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eql "Você já está logado"
      end
    end
  end

  describe "POST create" do
    context "email exists" do
      let!(:user)  { FactoryGirl.create :user }

      it "delivers password reset instructions" do
        expect {
          post :create, params: { user: { email: user.email } }
        }.to change { ActionMailer::Base.deliveries.size }.by(1)
      end

      it "creates reset password token" do
        expect(user.reload.reset_password_token).to     be_nil

        post :create, params: { user: { email: user.email } }

        expect(user.reload.reset_password_token).to_not be_nil
      end

      it "redirects to new_session_path" do
        post :create, params: { user: { email: user.email } }
        expect(response).to redirect_to new_session_path
      end

      it "sends flash notice" do
        post :create, params: { user: { email: user.email } }
        expect(flash[:notice]).to eql "Verifique seu email para receber instruções de recuperação de senha"
      end
    end

    context "email does not exists" do
      it "assigns user with wrong email" do
        post :create, params: { user: { email: "wrong@email.com" } }
        expect(assigns[:user].email).to eql "wrong@email.com"
      end

      it "renders new" do
        post :create, params: { user: { email: "wrong@email.com" } }
        expect(response).to render_template :new
      end

      it "sends flash alert" do
        post :create, params: { user: { email: "wrong@email.com" } }
        expect(flash[:alert]).to eql "Email não encontrado"
      end
    end

    context "when user is already logged in" do
      it "redirects to root path" do
        login_user(FactoryGirl.create :user)

        post :create, params: { id: "any token here" }
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eql "Você já está logado"
      end
    end
  end


  describe "PUT update" do
    context "when token exists" do
      let!(:user)  { FactoryGirl.create :user, reset_password_token: 123456 }

      it "redirects to new_session_path" do
        put :update, params: { id: user.reset_password_token, user: { password: "123456" } }
        expect(response).to redirect_to new_session_path
      end

      it "updates users password" do
        expect {
          put :update, params: { id: user.reset_password_token, user: { password: "123456" } }
        }.to change { user.reload.crypted_password }
      end

      it "delivers reseted password email notification" do
        expect {
          put :update, params: { id: user.reset_password_token, user: { password: "123456" } }
        }.to change { ActionMailer::Base.deliveries.size }.by(1)
      end

      it "sends flash notice" do
          put :update, params: { id: user.reset_password_token, user: { password: "123456" } }
        expect(flash[:notice]).to eql "Senha atualizada com sucesso. Entre com sua nova senha"
      end
    end

    context "when token does not exists" do
      it "redirect to new_session_path" do
        put :update, params: { id: "i dont exist" }
        expect(response).to redirect_to :new_session
      end

      it "sends flash alert" do
        put :update, params: { id: "i dont exist" }
        expect(flash[:alert]).to eql "Token para resetar senha expirado ou inválido"
      end
    end

    context "when user is already logged in" do
      it "redirects to root path" do
        login_user(FactoryGirl.create :user)

        put :update, params: { id: "any token here" }
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eql "Você já está logado"
      end
    end
  end
end
