Rails.application.routes.draw do
  mount_griddler
  
  resources :boats do
    resources :positions
  end

  root to: "boats#index"
end
