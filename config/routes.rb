Rails.application.routes.draw do

  # ゲストログイン
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

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

    resources :tags, only: [:index, :create, :edit, :update, :destroy]

    resources :users, only: [:show, :edit, :update]
  end

  # public

  scope module: :public do
    root to: 'homes#top'

    get 'homes/about' => "homes#about", as: "about"

    # get 'searches/search' => "searches#search", as: "search"
    # get 'searches/result' => "searches#result", as: "result"

    resources :photos do
      resource :favorites, only: [:create, :destroy]
      get 'userlist' => 'favorites#userlist', as: 'userlist'
      resources :comments, only: [:create, :destroy]
    end

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

end
