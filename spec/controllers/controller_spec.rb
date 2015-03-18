require 'rails_helper'

class BaseController < ApplicationController
  before_filter :authorize
end

describe BaseController, type: :controller do
  let!(:current_user)   { FactoryGirl.create(:user) }

  before do
    setup_authorization(current_user, "base", "index")
  end

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