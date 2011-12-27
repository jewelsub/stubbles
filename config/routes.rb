Stubbles::Application.routes.draw do
  root :to => 'welcome#index'

  devise_for :users

  resources :projects do
    resources :stories
  end

  resources :stories do
    resources :tasks
  end

end
