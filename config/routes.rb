Rails.application.routes.draw do
  
  get 'homes/top'
  get 'homes/about'
  get 'homes/beginner'
  get 'homes/already_work'
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
