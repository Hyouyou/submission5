Rails.application.routes.draw do
  devise_for :users
  resources :books, only:[:create, :show, :edit, :index, :update, :destroy] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  resources :relationships, only:[:create, :destroy]
  resources :users, only:[:show, :edit, :index, :update,]
  root 'homes#top'
  get'home/about' => 'homes#about'
  get'users/:id/follow' => 'users#follow', as:'follow'
  get'users/:id/follower' => 'users#follower', as:'follower'
  get 'search' => 'searchs#search', as:'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
