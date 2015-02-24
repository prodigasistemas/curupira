Rails.application.routes.draw do
  curupira_routes

  root to: "home#index"
end
