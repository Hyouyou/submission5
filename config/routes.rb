Rails.application.routes.draw do
  devise_for :users
  resources :books, only:[:create, :show, :edit, :index, :update, :destroy] do
    resource :book_comments, only:[:create]
  end
  resources :users, only:[:show, :edit, :index, :update,]
  root 'homes#top'
  get'home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
