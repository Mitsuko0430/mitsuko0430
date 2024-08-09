Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'hello/top' => 'hello#top'
  get 'hello/link' => 'hello#link'
  root 'hello#top'
  resources :users, only: [:show, :index] # ユーザーマイページへのルーティング
  resources :patients do
    namespace :admin do
      resources :restaurants, only: [:index, :new, :create, :show,  :edit, :destroy]
    end
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  get 'patient/dog' => 'patients#dog'
  get 'patient/cat' => 'patients#cat'
  get 'patient/hadakadebanezumi' => 'patients#hadakadebanezumi'
end