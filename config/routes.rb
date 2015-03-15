AuthDemo::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/contact"
  get "static_pages/about"
  root "sessions#new"

  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end
end
