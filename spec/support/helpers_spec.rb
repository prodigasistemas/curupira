require "rails_helper"

def login(user)
  visit '/session/new'
      
  fill_in 'Email ou Nome de usuário', :with => current_user.email
  fill_in 'Senha', :with => '12345678'
  
  click_button 'Entrar'

  visit '/'
end

def setup_authorization(current_user, controller_name, action_name)
  group_a = FactoryGirl.create(:group, name: "Group A") 
  role_a = FactoryGirl.create(:role, name: "Role A") 
  feature_a = FactoryGirl.create(:feature) 
  FactoryGirl.create(:authorization, role: role_a, feature: feature_a) 
  FactoryGirl.create(:role_group, role: role_a, group: group_a) 
  group_user = FactoryGirl.create(:group_user, user: current_user, group: group_a) 
  FactoryGirl.create(:role_group_user, role: role_a, group_user: group_user) 
  service = FactoryGirl.create(:service, name: controller_name) 
  FactoryGirl.create(:feature_service, feature: feature_a, service: service) 
  action_label = FactoryGirl.create(:action_label, name: action_name) 
  FactoryGirl.create(:feature_action_label, feature: feature_a, action_label: action_label) 
end