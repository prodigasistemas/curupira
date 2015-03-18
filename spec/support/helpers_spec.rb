require "rails_helper"

def login(user)
  visit '/session/new'
      
  fill_in 'Email ou Nome de usuário', :with => user.email
  fill_in 'Senha', :with => '12345678'
  
  click_button 'Entrar'

  visit '/'
end

def setup_authorization(current_user, controller_name, action_name)
  group_a = FactoryGirl.create(:group, name: "Group A") 
  role_a = FactoryGirl.create(:role, name: "Role A") 
  feature_a = FactoryGirl.create(:feature, controller: controller_name) 
  FactoryGirl.create(:authorization, role: role_a, feature: feature_a) 
  FactoryGirl.create(:role_group, role: role_a, group: group_a) 
  group_user = FactoryGirl.create(:group_user, user: current_user, group: group_a) 
  FactoryGirl.create(:role_group_user, role: role_a, group_user: group_user) 
  action_label = FactoryGirl.create(:action_label, name: action_name, feature: feature_a)
end