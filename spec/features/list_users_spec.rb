require "rails_helper"

describe "list users" do
  let!(:ike) { FactoryGirl.create(:user, name: "Ike", email: 'ike@email.com') }
  let!(:mou) { FactoryGirl.create(:user, name: "Mou", email: 'mou@email.com') }

  describe "Users should visualize users that belongs to his group" do
    subject!(:current_user) { FactoryGirl.create(:user) }
    let!(:group) { FactoryGirl.create(:group, users: [current_user, ike]) }

    before do
      setup_authorization(current_user, "curupira/users", "index")
      login(current_user)

      visit "/users"
    end

    it "just visualize users that belongs to his group" do
      expect(page).to     have_content("Ike")
      expect(page).to_not have_content("Mou")
    end
  end

  describe "Admin should visualize all users" do
    subject!(:admin) { FactoryGirl.create(:user, admin: true) }

    before do
      login(admin)

      visit "/users"
    end

    it "visualize all users" do
      expect(page).to have_content("Ike")
      expect(page).to have_content("Mou")
    end
  end
end