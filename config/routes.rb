Rails.application.routes.draw do
  resources :votes do 
    get "vote_review", to: "votes#vote_review", on: :collection
    get "vote_final", to: "votes#vote_final", on: :collection
    get "vote_success", to: "votes#vote_success", on: :collection
    get "vote", to: "votes#vote", on: :collection
    get "result", to: "votes#result", on: :collection
  end

  devise_for :users
  # resources :users
   
  resources :elections
  resources :registrations do 
    get "new_modal", to: "registrations#new_modal", as: "new_modal", on: :collection
    get "edit_modal", to: "registrations#edit_modal", as: "edit_modal"
    get "dash_board", to: "registrations#dash_board", as: "dash_board", on: :collection
    get "attend", to: "registrations#attend", on: :member
    get "paid", to: "registrations#paid", on: :member
  end
  resources :candidates do 
    get "new_edit", to: "candidates#new_edit", as: "new_edit", on: :collection
  end
  resources :elect_positions
  resources :participants
  resources :event_hubs do 
    get "coop", on: :collection
    get "home", on: :collection
    patch "voter_code", on: :collection
    get "vote", on: :member
  end
  resources :coop_events
  resources :cooperatives
  resources :geo_barangays
  resources :geo_municipalities do
    get :selected, on: :member
  end
  resources :geo_provinces do
    get :selected, on: :member
  end
  resources :geo_regions  do
    get :selected, on: :member
  end
  resources :pages do 
    get "event_hub", to: "pages#event_hub", as: "event", on: :member
    get "register", to: "pages#register", as: "register", on: :collection
    get "vote", to: "pages#vote", as: "vote", on: :collection
  end
    # post :coop, on: :collection, to: "pages#coop"
    # post "coop", on: :collection, to: "pages#coop"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#vote"
  # get "pages/register", to: "pages#register", as: 'registration_post'
  
  #get "registrations/new_modal", to: "registrations#new_modal", as: "registration_new_modal"
  # get "registrations/edit_modal", to: "registrations#edit_modal", as: "registration_edit_modal"
end
