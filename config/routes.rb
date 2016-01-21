Rails.application.routes.draw do
  resources :questions

  devise_for :users
  
  resources :users do
  	member do
  		get 'confirmation'
  	end
  end
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
