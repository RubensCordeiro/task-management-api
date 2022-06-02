Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      scope :registration do
        post '/', to: "users#create"
        patch '/', to: "users#update"
        delete '/', to: "users#destroy"
      end

      scope :authentication do
        post '/', to: "authentications#authenticate"
      end

      scope :tasks do
        get '/(:filter)', to: "tasks#index"
        get '/task/:id', to: "tasks#show"
        post '/', to: "tasks#create"
        patch '/:id', to: "tasks#update"
        delete '/:id', to: "tasks#destroy"
      end
    end
  end
end
