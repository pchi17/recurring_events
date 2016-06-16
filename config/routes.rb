Rails.application.routes.draw do
  root 'recurring_events#index'
  resources :recurring_events
end
