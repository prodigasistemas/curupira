require 'rails_helper'
require "curupira/authorizer"

describe Curupira::Authorizer do
  include Curupira::Authorizer
  let!(:user) { FactoryGirl.create(:user) }
  let!(:authorization) { FactoryGirl.create(:authorization) }
  let!(:group_role) { FactoryGirl.create(:group_role, role: authorization.role) }
  let!(:group_user) { FactoryGirl.create(:group_user, user: user, group: group_role.group) }
  
  context "when user have authorization" do
    it "authorize returns true" do
      expect(authorize?(user, "users", "create")).to be true
    end
  end
  
  context "when user not have authorization" do
    it "authorize returns false" do
      expect(authorize?(user, "users", "destroy")).to be false
    end
  end
end