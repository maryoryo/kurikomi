Rails.application.routes.draw do
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  devise_for :admins, controllers: {
    sessions: 'admin/users/sessions',
    registrations: 'admin/users/registrations'
  }
  namespace :admin do
    get 'groups/index'
    get 'groups/show'
    get 'groups/new'
    get 'groups/create'
    get 'groups/edit'
    get 'groups/update'
    
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    
    get 'genres/index'
    get 'genres/edit'
  end
  
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  namespace :public do
    get 'groups/index'
    get 'groups/show'
    get 'groups/new'
    get 'groups/create'
    get 'groups/edit'
    get 'groups/update'
    
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/quit'
    get 'users/withdraw'
  end
  
  
  root 'homes#top'
  get 'homes/about'
  get 'homes/beginner'
  get 'homes/already_work'
  
end
