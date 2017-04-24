Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :survivors do
        post 'report_infection' => 'survivors#report_infection', on: :member
      end

      get '/items', to: 'items#index'
      post '/items/trade', to: 'items#trade'

      get '/reports', to: 'reports#index'
    end
  end

  # match "" => lambda { |r| [ 404, {}, []] }, via: [:all]
  get '*any', :to => redirect('/index.html')

end
