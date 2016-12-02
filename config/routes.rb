Rails.application.routes.draw do
  resources :cards, only: [:show]
  resources :games do
    get :invite
    post :accept
    get :cards
    post :pick
  end
  devise_for :players
  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
