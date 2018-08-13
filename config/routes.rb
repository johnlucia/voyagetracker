Rails.application.routes.draw do
  resources :boats do
    resources :positions
  end

  root to: "boats#index"
end
