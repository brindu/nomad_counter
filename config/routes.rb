Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Slack::API => '/'

  root "slack_posts#index"

  resources :slack_posts, only: [:index] do
    resources :events, only: [:new]

    member do
      post :discard
    end
  end

end
