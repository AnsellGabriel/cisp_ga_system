Rails.application.routes.draw do
  resources :referendum_responses
  resources :referendums do
    post :submit_answers, on: :collection
  end
  get "home/index"
  resources :votes do
    get "vote_review", to: "votes#vote_review", on: :collection
    get "vote_final", to: "votes#vote_final", on: :collection
    get "vote_success", to: "votes#vote_success", on: :collection
    get "vote", to: "votes#vote", on: :collection
    get "result", to: "votes#result", on: :collection
    get "vote_all", to: "votes#vote_all", on: :collection
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
    get "hot_to_vote", to: "registrations#how_to_vote", as: "how_to_vote", on: :collection
    get "success", to: "registrations#success", as: "success", on: :collection
    get "size", to: "registrations#size", as: "size", on: :collection
    get "data_privacy", to: "registrations#data_privacy", as: "data_privacy", on: :collection
    get "registration_closed", to: "registrations#registration_closed", as: "closed", on: :collection
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
  resources :geo_regions do
    get :selected, on: :member
  end
  resources :pages do
    get "event_hub", to: "pages#event_hub", as: "event", on: :member
    get "register", to: "pages#register", as: "register", on: :collection
    get "vote", to: "pages#vote", as: "vote", on: :collection
    get "coming_soon", to: "pages#coming_soon", as: "coming_soon", on: :collection
    get "program", to: "pages#program", as: "program", on: :collection
    get "announcement", to: "pages#announcement", as: "announcement", on: :collection
  end
  # post :coop, on: :collection, to: "pages#coop"
  # post "coop", on: :collection, to: "pages#coop"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "pages#home"
  root "pages#home"
  # get "pages/register", to: "pages#register", as: 'registration_post'

  #get "registrations/new_modal", to: "registrations#new_modal", as: "registration_new_modal"
  # get "registrations/edit_modal", to: "registrations#edit_modal", as: "registration_edit_modal"
end
