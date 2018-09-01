Rails.application.routes.draw do
  mount_griddler
  
  resources :boats do
    resources :positions
    resources :status
  end

  root to: "boats#index"
end
