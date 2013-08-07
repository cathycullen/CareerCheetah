CareerCheetah::Application.routes.draw do
  resources :programs do
    resources :phases do
      resources :sections do
        resources :questions do
        end
      end
    end
  end

  resource :program_navigation do
    member do
      get "next"
      get "previous"
    end
  end

  namespace :admin do
    resources :programs
  end
end
