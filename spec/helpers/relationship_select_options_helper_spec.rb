require "rails_helper"

describe Curupira::RelationshipSelectOptionsHelper do
  describe "#active_user_groups_select_options" do
    let!(:active_group1) { FactoryGirl.create(:group, active: true) }
    let!(:active_group2) { FactoryGirl.create(:group, active: true) }
    let!(:inactive_group) { FactoryGirl.create(:group, active: false) }

    it "returns default with active groups" do
      expect(helper.active_user_groups_select_options).to eql [
        ["Selecione um grupo", nil],
        [active_group1.name, active_group1.id],
        [active_group2.name, active_group2.id]
      ]
    end
  end
end
