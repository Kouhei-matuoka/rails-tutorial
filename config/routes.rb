Rails.application.routes.draw do

  #get 'password_resets/new'

  #get 'password_resets/edit'

  root  'static_pages#top'
  #get   '/help',    to: 'static_pages#help'
  #get   '/about',   to: 'static_pages#about'
  #get   '/contact', to: 'static_pages#contact'
  get   '/signup',  to: 'users#new'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  devise_scope :user do
  get 'logout' => 'sessions#destroy'
  end
  
  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks"
}
  
  resources :questions 
  resources :users do
  member do
      get 'dry_skin'
      get 'normal_skin'
      get 'mixed_skin'
      get 'oily_skin'
    end
  end
  resources :question_steps, only: [:index, :show, :update]
  #resources :account_activations, only: [:edit]
  #resources :password_resets,     only: [:new, :create, :edit, :update]
  #resources :microposts,          only: [:create, :destroy]
  #resources :relationships,       only: [:create, :destroy]
end
