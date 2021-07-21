Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations'
  }
  namespace :admin do
    get 'homes/top' => 'homes#top'
    
    get 'searchs/search' => 'searchs#search'
    
    resources :users, only: [:index, :show]
    
    resources :groups, only: [:index, :show, :destroy] do
      get 'members' => 'groups#members'
      resources :group_posts, only: [:index, :show, :destroy]
    end
    
    resources :group_posts do
      resources :group_post_comments, only: [:destroy]
    end
    
    resources :genres, only: [:index, :show, :create, :edit, :update, :destroy]

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
    
    get 'searchs/search' => 'searchs#search'
    
    get '/groups/hashtag/:name' => 'groups#hashtag'
    
     resources :users, only: [:index, :show, :edit, :update] do
      get 'users/quit' => 'users#quit'
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    resources :groups, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      get 'join' => 'groups#join'
      delete 'unjoin' => 'groups#unjoin'
      get 'members' => 'groups#members'
      resources :group_posts, only: [:show, :new, :create, :edit, :update, :destroy]
    end
    
    resources :group_posts do
      resources :group_post_comments, only: [:create, :destroy]
      resources :group_post_favorites, only: [:create, :destroy]
    end
    
    resources :chats, only: [:show, :create]
    
    resources :genres, only: [:index, :show]
    
  end


end
