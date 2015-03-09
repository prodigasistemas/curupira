require "rails_helper"

describe "link authorize" do
  let!(:current_user) { FactoryGirl.create(:user) }

  context "when user have authorization" do
    let!(:group_a) { FactoryGirl.create(:group, name: "Group A") }
    let!(:role_a) { FactoryGirl.create(:role, name: "Role A") }
    let!(:feature_a) { FactoryGirl.create(:feature, description: "Feature A", controller: "home", action: "test") }
    let!(:authorization) { FactoryGirl.create(:authorization, role: role_a, feature: feature_a) }
    let!(:role_group) { FactoryGirl.create(:role_group, role: role_a, group: group_a) }
    let!(:group_user) { FactoryGirl.create(:group_user, user: current_user, group: group_a) }
    let!(:permission) { FactoryGirl.create(:permission, role: role_a, group_user: group_user) }

    before do
      login(current_user)

      click_link "Test"
    end

    it { expect(page).to have_content("Sucess!") }
  end

  context "when user not have authorization" do
    before do
      login(current_user)
    end

    it { expect(page.has_selector?('.not-allowed')).to be true }
  end
end