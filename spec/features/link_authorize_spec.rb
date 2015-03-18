require "rails_helper"

describe "link authorize" do
  let!(:current_user) { FactoryGirl.create(:user) }

  context "when user have authorization" do

    before do
      setup_authorization(current_user, "home", "test")
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