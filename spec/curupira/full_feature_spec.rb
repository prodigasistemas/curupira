require 'rails_helper'
require "curupira/authorizer"

describe Curupira::Authorizer do
  include Curupira::Authorizer
  
  describe "#has_authorization?" do
    let!(:current_user) { FactoryGirl.create(:user) }
    let(:params) do
      {
        controller: "users",
        action: "create"
      }
    end

    before do
      setup_authorization(current_user, "users", "manage")
    end

    it "have authorization" do
      expect(has_authorization?).to be true
    end
  end
end