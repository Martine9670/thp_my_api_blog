Rails.application.routes.draw do
  # 1. On définit la page d'accueil pour voir ton JSON directement
  root "articles#index"

  # 2. On lie Devise aux contrôleurs API (indispensable pour éviter l'erreur 500)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 3. Tes routes pour les articles
  resources :articles

  # Route de santé par défaut de Rails 8
  get "up" => "rails/health#show", as: :rails_health_check
end