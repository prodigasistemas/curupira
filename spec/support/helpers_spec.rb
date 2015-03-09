def login(user)
  visit '/session/new'
      
  fill_in 'Email ou Nome de usuário', :with => current_user.email
  fill_in 'Senha', :with => '12345678'
  
  click_button 'Entrar'

  visit '/'
end