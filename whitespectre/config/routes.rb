Rails.application.routes.draw do
  # since the app is api only we dont use `api` scope
  namespace :v1 do
    resources :group_events
  end
end
