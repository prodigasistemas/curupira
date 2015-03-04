require 'rails_helper'
require "curupira/authorizer"

describe Curupira::Authorizer do
  let!(:current_user) { FactoryGirl.create(:user) }
  let!(:authorization) { FactoryGirl.create(:authorization) }
  let!(:group_role) { FactoryGirl.create(:group_role, role: authorization.role) }
  let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: group_role.group) }
  
  include Curupira::Authorizer

  describe "#has_authorization?" do
    context "when user have authorization" do
      let(:params) do
        { controller: 'users', action: 'create' }
      end

      it "authorize returns true" do
        expect(has_authorization?).to be true
      end
    end

    context "when user not have authorization" do
      let(:params) do
        { controller: 'users', action: 'destroy' }
      end

      it "authorize returns false" do
        expect(has_authorization?).to be false
      end
    end
  end
end