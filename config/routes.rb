Rails.application.routes.draw do
  
  resources :questions do
  	resources :answers, only: [:create, :new, :update, :edit]
  end

  devise_for :users, controllers: { registrations: "registrations" }
  
  resources :users, except:[:edit] do
  	member do
  		get 'confirmation'
  	end
  end
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
