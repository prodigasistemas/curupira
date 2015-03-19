require "rails_helper"

describe Curupira::RelationshipSelectOptionsHelper do
  describe "#active_user_groups_select_options" do

    context 'when user is admin' do
      let!(:user){FactoryGirl.create(:user, admin:true)}
      let!(:active_group1) { FactoryGirl.create(:group, active: true) }
      let!(:active_group2) { FactoryGirl.create(:group, active: true) }

      it "return groups" do
        expect(helper.active_user_groups_select_options(user)).to eql [
          ["Selecione um grupo", nil],
          [active_group1.name, active_group1.id],
          [active_group2.name, active_group2.id]
        ]
      end      
    end

    context 'when user is not admin' do
      let!(:active_group1) { FactoryGirl.create(:group, active: true) }
      let!(:active_group2) { FactoryGirl.create(:group, active: true) }
      let!(:inactive_group) { FactoryGirl.create(:group, active: false) }
      let!(:user) { FactoryGirl.create(:user, groups: [active_group1, active_group2]) }

      it "returns default with active groups" do
        expect(helper.active_user_groups_select_options(user)).to eql [
          ["Selecione um grupo", nil],
          [active_group1.name, active_group1.id],
          [active_group2.name, active_group2.id]
        ]
      end
      context "when doesnt belongs to any group" do
        let!(:user2) { FactoryGirl.create(:user)}
        it "doesnt return any groups" do
          expect(helper.active_user_groups_select_options(user2)).to eql [
            ["Selecione um grupo", nil]
          ]
        end
      end
    end
  end
end
