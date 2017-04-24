Rails.application.routes.draw do
  resource :distance, only: [:create]
  resource :cost, only: [:show]
end
