Rails.application.routes.draw do
  root to: 'geniusifier#show'

  resource :geniusifier, :controller => :geniusifier
end
