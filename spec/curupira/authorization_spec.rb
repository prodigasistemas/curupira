require 'rails_helper'
require "curupira/authorizer"

describe Curupira::Authorizer do
  subject!(:current_user)   { FactoryGirl.create(:user) }
  
  include Curupira::Authorizer

  describe "#has_authorization?" do
    describe "user have role_a and belongs to group_a" do

      before do
        setup_authorization(current_user, "users", "create")
      end


      context "when role_a belongs to group_a" do

        let(:params) do
          {
            controller: "users",
            action: "create"
          }
        end

        it "have authorization to access the feature_a" do
          expect(has_authorization?).to be true
        end
      end

      context "when role_a belongs to group_b" do
        let(:params) do
          {
            controller: "users",
            action: "report"
          }
        end

        let!(:group_b) { FactoryGirl.create(:group, name: "Group B") }
        let!(:role_b) { FactoryGirl.create(:role, name: "Role B") }
        # let!(:role_group) { FactoryGirl.create(:role_group, role: role_a, group: group_b) }
        # let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: group_b) }
        # let!(:role_group_user) { FactoryGirl.create(:role_group_user, role: role_b, group_user: group_user) }

        before do
          role_a = Role.first
          FactoryGirl.create(:role_group, role: role_a, group: group_b)
          group_user = FactoryGirl.create(:group_user, user: current_user, group: group_b)
          FactoryGirl.create(:role_group_user, role: role_b, group_user: group_user)
        end

        it "don't have authorization to access the feature_a" do
          expect(has_authorization?).to be false
        end
      end
    end
  end
end