require 'rails_helper'
require "curupira/authorizer"

describe Curupira::Authorizer do
<<<<<<< HEAD
  subject!(:current_user)   { FactoryGirl.create(:user) }
=======
  let!(:current_user) { FactoryGirl.create(:user) }
  let!(:authorization) { FactoryGirl.create(:authorization) }
  let!(:role_group) { FactoryGirl.create(:role_group, role: authorization.role) }
  let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: role_group.group) }
>>>>>>> fix tests
  
  include Curupira::Authorizer

  describe "#has_authorization?" do
    describe "user have role_a and belongs to group_a" do
      let(:params) do
        {
          controller: "users",
          action: "create"
        }
      end

      let!(:group_a) { FactoryGirl.create(:group, name: "Group A") }
      let!(:role_a) { FactoryGirl.create(:role, name: "Role A") }
      let!(:feature_a) { FactoryGirl.create(:feature, description: "Feature A", controller: "users", action: "create") }
      let!(:authorization) { FactoryGirl.create(:authorization, role: role_a, feature: feature_a) }
      let!(:role_group) { FactoryGirl.create(:role_group, role: role_a, group: group_a) }
      let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: group_a) }
      let!(:permission) { FactoryGirl.create(:permission, role: role_a, group_user: group_user) }

      context "when role_a belongs to group_a" do
        it "have authorization to access the feature_a" do
          expect(has_authorization?).to be true
        end
      end

      context "when role_a belongs to group_b" do
        let!(:group_b) { FactoryGirl.create(:group, name: "Group B") }
        let!(:role_b) { FactoryGirl.create(:role, name: "Role B") }
        let!(:role_group) { FactoryGirl.create(:role_group, role: role_a, group: group_b) }
        let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: group_b) }
        let!(:permission) { FactoryGirl.create(:permission, role: role_b, group_user: group_user) }

        it "don't have authorization to access the feature_a" do
          expect(has_authorization?).to be false
        end
      end
    end
  end
end