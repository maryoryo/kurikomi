Rails.application.routes.draw do



  namespace :public do
    get 'genres/index'
    get 'genres/show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations'
  }
  namespace :admin do
    get 'homes/top' => 'homes#top'
    
    resources :groups, only: [:index, :show, :new, :create, :edit, :update]
    
    resources :users, only: [:index, :show, :edit, :update]
    
    resources :genres, only: [:index, :show, :new, :create, :edit, :destroy]
    
    get 'searchs/search' => 'searchs#search'

  end


  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }
  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get 'homes/beginner'
    get 'homes/already_work'
    
    resources :groups, only: [:index, :show, :new, :create, :edit, :update]
    
    resources :users, only: [:index, :show, :edit, :update]
    
    get 'users/quit' => 'users#quit'
    get 'users/withdraw' => 'users#withdraw'
    
    get 'searchs/search' => 'searchs#search'
  end


end
