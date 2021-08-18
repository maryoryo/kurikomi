Rails.application.routes.draw do

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 管理者側のルーティング
  devise_for :admins, controllers: {
    sessions: 'admin/admins/sessions',
    registrations: 'admin/admins/registrations',
    passwords: 'admin/admins/passwords'
  }
  namespace :admin do
    get 'homes/top' => 'homes#top'
    
    get 'searchs/search' => 'searchs#search'
    
    get 'groups/hashtag/:name' => 'groups#hashtag'
    
    resources :users, only: [:index, :show]
    
    resources :groups, only: [:index, :show, :destroy] do
      get 'members' => 'groups#members'
      resources :group_posts, only: [:show, :destroy]
    end
    
    resources :group_posts do
      resources :group_post_comments, only: [:destroy]
    end
    
    resources :genres, only: [:index, :show, :edit, :new, :create, :update, :destroy]
  end


  # ユーザー側のルーティング
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
    passwords: 'public/users/passwords',
    omniauth_callbacks: 'public/users/omniauth_callbacks'
  }
  devise_scope :user do
    post 'users/guest_sign_in' => 'public/users/sessions#guest_sign_in'
  end
  
  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get 'homes/beginner'
    get 'homes/already_work'
    
    get 'searchs/search' => 'searchs#search'
    
    get 'groups/hashtag/:name' => 'groups#hashtag'
    
    get 'notifications/index' => 'notifications#index'
    
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
    
    get 'inquiries/index'
    post 'inquiries/create'
    post 'inquiries/confirm'
    get 'inquiries/thanks'
  
  end
end
