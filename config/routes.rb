Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

# 顧客用
# URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # admin

  namespace :admin do
    get 'homes/top' => "homes#top", as: "top"

    resources :tags, only: [:index, :create, :edit, :update]

    resources :users, only: [:show, :edit, :update]
  end

  # public

  scope module: :public do
    root to: 'homes#top'

    get 'homes/about' => "homes#about", as: "about"

    get 'searches/search' => "searches#search", as: "search"
    get 'searches/result' => "searches#result", as: "result"

    get 'relationships/followings' => "relationships#followings", as: "followings"
    get 'relationships/followers' => "relationships#followers", as: "followers"
    resource :relationships, only: [:create, :destroy]

    resources :photos do
      resource :favorites, only: [:create, :destroy]
    end

    resources :comments, only: [:create, :destroy]

    resources :photos

    # patch 'users/status' => "users#status", as: "status"
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
    end
  end

end
