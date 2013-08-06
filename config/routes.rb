CareerCheetah::Application.routes.draw do
  resources :programs do
    resources :phases do
      resources :sections do
        resources :section_questions, :as => :section_question_mapping
      end
    end
  end

  namespace :admin do
    resources :programs
  end
end
