Rails.application.routes.draw do
  root 'patients#index'

  resources :patients do
    resources :appointments
    resources :medical_records
  end

  resources :doctors do
    resources :appointments
    resources :medical_records
  end
end
