Rails.application.routes.draw do
  # 1. Page d'accueil (JSON des articles)
  root "articles#index"

  # 2. Authentification Devise
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 3. Articles + Commentaires imbriqués
  resources :articles do
    resources :comments, only: [:create, :index, :destroy, :update] # Uniquement ce dont on a besoin
  end

  # Route de santé Rails 8
  get "up" => "rails/health#show", as: :rails_health_check
end