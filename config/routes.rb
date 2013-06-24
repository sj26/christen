Christen::Application.routes.draw do
  devise_for :users

  resources :domains, only: [:index, :new, :create, :show, :destroy], constraints: {id: /.+?/, format: /html|json|pem/} do
    constraints(domain_id: /.+?/) do
      resources :records, only: [:new, :create, :edit, :update, :destroy]
      resources :certificates, only: [:new, :create, :show]
    end
  end

  authenticated do
    root to: redirect("/domains"), as: :authenticated_root
  end

  get :cert, to: "home#cert"

  root to: "home#show"
end
