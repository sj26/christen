Christen::Application.routes.draw do
  devise_for :users

  resources :domains, only: [:index, :new, :create, :show, :destroy], constraints: {id: /.+?/, format: /html|json/} do
    constraints(domain_id: /.+?/) do
      resources :records, only: [:new, :create, :edit, :update, :destroy]
      resources :certificates, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  authenticated do
    root to: redirect("/domains"), as: :authenticated_root
  end

  root to: "home#show"
end
