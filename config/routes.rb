Rails.application.routes.draw do
  root 'home#index'
  get 'google_authentication/login'
  get 'oauth2callback/check'
  get 'search/show'
end
