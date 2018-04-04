Rails.application.routes.draw do
  resources :notes do
    post 'sync', on: :collection
  end

end
