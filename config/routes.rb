Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      scope :registration do
        post '/', to: "users#create"
        patch '/', to: "users#update"
        delete '/', to: "users#destroy"
      end
    end
  end
end
