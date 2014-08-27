Rails.application.routes.draw do
  resources :delegation_entries

  resources :delegations do
    collection { get :add_delegation_entry }
  end

  resources :organizations

  resources :issues do
    member do
      post :upvote
      post :downvote
      post :voteyea
      post :votenay
      patch :revert
      patch 'theses-for/reorder', action: :reorder_theses_for, as: :reorder_theses_for
      patch 'theses-against/reorder', action: :reorder_theses_against, as: :reorder_theses_against
    end
    resources :theses, except: [:index, :destroy] do
      member do
        patch :revert
        delete :remove
      end
    end
  end

  root :to => 'issues#index'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :users do
    member do
      get :delegate
    end
  end
end
