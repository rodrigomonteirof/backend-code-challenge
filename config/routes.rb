Rails.application.routes.draw do
  resource :distance, only: [:create, :destroy]
end
