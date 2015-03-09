Rails.application.routes.draw do
  curupira_routes

  root to: "home#index"
  get "home/test", to: "home#test"
end
