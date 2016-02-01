Rails.application.routes.draw do
  
  resources :labels, only: [:show]

  resources :questions do
    member do
      post 'vote'
    end
  	resources :answers, only: [:create, :new, :update, :edit] do
      member do
        post 'vote'
      end
    end
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
