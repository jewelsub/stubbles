Stubbles::Application.routes.draw do
  root :to => 'welcome#index'

  devise_for :users

  resources :projects do
    resources :stories
    member do
      post 'add_member'
    end
    resources :project_memberships
  end

  resources :stories do
    resources :tasks
  end

  get 'users/:id' => 'users#show', :as => 'user'
  get 'user/search' => 'users#search_new', :as => 'new_user_search'
  post 'user/search' => 'users#search', :as => 'user_search'

end