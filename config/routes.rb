Christen::Application.routes.draw do
  devise_for :users

  resources :domains, only: [:index, :new, :create, :show, :destroy], constraints: {id: /.+?/, format: /html|json/} do
    resources :records, only: [:new, :create, :edit, :update, :destroy], constraints: {domain_id: /.+?/}
  end

  authenticated do
    root to: redirect("/domains"), as: :authenticated_root
  end

  root to: "home#show"
end
