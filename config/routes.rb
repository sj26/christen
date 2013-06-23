Christen::Application.routes.draw do
  devise_for :users

  resources :domains, only: [:index, :new, :create, :show, :destroy] do
    resources :records, only: [:new, :create, :edit, :update, :destroy]
  end

  authenticated do
    root to: redirect("/domains"), as: :authenticated_root
  end

  root to: "home#show"
end
