require 'rails_helper'

describe "login", type: :feature do
  let!(:user) { FactoryGirl.create :user }
  
  it "signs me in" do
    visit '/session/new'
    
    fill_in 'Email ou Nome de usuário', :with => user.email
    fill_in 'Senha', :with => '12345678'
    
    click_button 'Entrar'
    expect(page).to have_content 'Bem vindo!'
  end
end