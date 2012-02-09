Stubbles::Application.routes.draw do
  root :to => 'welcome#index'

  devise_for :users

  resources :projects do
    resources :stories do #, :only => [:index, :show]
      member do
        post 'update_scope_and_priority'
      end
    end
    resources :project_memberships do
      member do
        put 'update_role'
        put 'activate'
        put 'deactivate'
      end
    end
    resources :dashboard
  end

  resources :stories do
    resources :tasks
  end

  get  'users/:id' => 'users#show', :as => 'user'
  get  'user/search' => 'users#search_new', :as => 'new_user_search'
  post 'user/search' => 'users#search', :as => 'user_search'

end