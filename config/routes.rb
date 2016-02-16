Rails.application.routes.draw do
  
  resources :labels, only: [:show]

  resources :questions do
  	resources :answers, only: [:create, :new, :update, :edit]
  end

  resources :answers, only: [] do
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks', registrations: 'registrations' }

  resources :users, except:[:edit] do
  	member do
  		get 'confirmation'
  	end
  end
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'

end
