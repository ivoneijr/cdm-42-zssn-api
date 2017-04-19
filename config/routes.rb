Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :items
      resources :survivors do
        post 'report_infection' => 'survivors#report_infection', on: :member
      end

      get '/reports', to: 'reports#index'
    end
  end
end
