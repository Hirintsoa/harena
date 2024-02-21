Rails.application.routes.draw do
  root 'dashboard#index'
  # get 'components/automation'
  get 'new_movement/tag'
  
  resources :activities do
    resources :wishes
    resources :incomes, except: %i[ new create ]
    resources :expenses, except: %i[ new create ]
    get 'income/new', to: 'new_movement#base_step', defaults: { type: 'income' }
    get 'expense/new', to: 'new_movement#base_step', defaults: { type: 'expense' }
    get 'new_movement/back'
    post 'new_movement/base_step'
    post 'new_movement/configuration_step'
  end


  devise_for :accounts, path: 'auth', controllers: {
                                                    sessions: 'accounts/sessions',
                                                    registrations: 'accounts/registrations'
                                                  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount GoodJob::Engine => 'good_job'
  mount ActionCable.server => '/cable'

  # Defines the root path route ("/")
  # root "posts#index"
end
