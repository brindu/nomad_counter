Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Slack::API => '/'

  root "slack_posts#unpublished"

  resources :slack_posts, only: [] do
    collection do
      get :unpublished
    end
  end
end
