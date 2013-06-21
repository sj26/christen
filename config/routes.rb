Christen::Application.routes.draw do
  devise_for :users

  resources :domains, only: [:index, :new, :create, :show, :destroy]

  authenticated do
    root to: redirect("/domains"), as: :authenticated_root
  end

  root to: "home#show"
end
