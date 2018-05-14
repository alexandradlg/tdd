Rails.application.routes.draw do
  get 'user/show'
  devise_for :users
  resources :users, :only => [:show]
  root 'index#home'
  get '/club', to: 'index#club'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
