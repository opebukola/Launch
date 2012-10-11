Launch::Application.routes.draw do
  root to: "pages#home"
  resources :users
  match '/about', to: 'pages#about'
  match '/careers', to: 'pages#careers'
end
