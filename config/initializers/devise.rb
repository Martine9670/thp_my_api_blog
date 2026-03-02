# frozen_string_literal: true

Devise.setup do |config|
  # Expéditeur des mails par défaut
  config.mailer_sender = 'no-reply@my-api-blog.com'

  # Charge l'ORM ActiveRecord
  require 'devise/orm/active_record'

  # Configuration des clés d'authentification
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Désactive le stockage en session (crucial pour une API stateless)
  config.skip_session_storage = [:http_auth]

  # Sécurité des mots de passe
  config.stretches = Rails.env.test? ? 1 : 12
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Récupération de mot de passe
  config.reset_password_within = 6.hours

  # Méthode de déconnexion
  config.sign_out_via = :delete

  # Gestion des erreurs compatible avec Rails 7+
  config.responder.error_status = :unprocessable_content
  config.responder.redirect_status = :see_other

  # MODE API : On vide les formats de navigation pour éviter les redirections HTML
  config.navigational_formats = []

  # CONFIGURATION JWT
  config.jwt do |jwt|
    # Utilise la clé secrète de ton application pour signer les tokens
    jwt.secret = Rails.application.credentials.fetch(:secret_key_base)
    
    # Définit les routes qui vont générer un token (Login)
    jwt.dispatch_requests = [
      ['POST', %r{^/users/sign_in$}]
    ]
    
    # Définit les routes qui vont révoquer le token (Logout)
    jwt.revocation_requests = [
      ['DELETE', %r{^/users/sign_out$}]
    ]
    
    # Durée de validité du badge (24 heures)
    jwt.expiration_time = 24.hours.to_i
  end
end