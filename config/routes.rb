Rails.application.routes.draw do
  resources :survivors do
    post 'report_infection' => 'survivors#report_infection', on: :member
  end
end
