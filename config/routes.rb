Rails.application.routes.draw do


  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations'
  }
  namespace :admin do
    get 'homes/top' => 'homes#top'
    
    resources :groups, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :group_posts, only: [:index, :show, :new, :create, :destroy]
    end
    
    resources :users, only: [:index, :show]
    
    resources :genres, only: [:index, :show, :create, :edit, :update, :destroy]
    
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
    
    resources :groups, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      get 'join' => 'groups#join'
      delete 'unjoin' => 'groups#unjoin'
      get 'members' => 'groups#members'
      resources :group_posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
    
    resources :users, only: [:index, :show, :edit, :update] do
      get 'users/quit' => 'users#quit'
      get 'users/withdraw' => 'users#withdraw'
    end
    
    get 'searchs/search' => 'searchs#search'
    
    resources :genres, only: [:index, :show]
  end


end
