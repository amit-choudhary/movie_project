Rails.application.routes.draw do
  apipie
  resources :locations, only: [] do
    get :all, on: :collection
    get :movies, on: :member
  end

  resources :movies, only: [] do
    get :all, on: :collection
    get :locations, on: :member
  end
end
