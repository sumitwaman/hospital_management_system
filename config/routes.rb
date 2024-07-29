Rails.application.routes.draw do
  root 'patients#index'

  resources :patients do
    get :create_appointment_form
    resources :appointments

    resources :medical_records
  end

  resources :doctors do
    resources :appointments
    resources :medical_records
  end
end
