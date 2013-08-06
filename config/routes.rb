CareerCheetah::Application.routes.draw do
  namespace :admin do
    resources :programs
  end
end
