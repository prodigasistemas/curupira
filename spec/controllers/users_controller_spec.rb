require "rails_helper"

describe Curupira::UsersController do
  describe "GET index" do
    before do
      FactoryGirl.create :user
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
end
