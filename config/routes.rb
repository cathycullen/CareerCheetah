CareerCheetah::Application.routes.draw do
  resources :programs do
    resources :phases do
      resources :sections do
        resources :questions
        resources :factor_ratings
      end
      resources :section_conclusions
    end
  end

  resources :response_option_selections
  resources :user_careers

  resource :program_navigation do
    member do
      get "next"
      get "previous"
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  match '/login',  to: 'sessions#new',         via: 'get'
  match '/logout', to: 'sessions#destroy',     via: 'delete'

  namespace :admin do
    resources :programs
  end

  root "sessions#new"
end
