Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*" # Plus tard, on mettra l'adresse de ton site React

    resource "*",
      headers: :any,
      expose: ["Authorization"], # TRÈS IMPORTANT : permet au front de lire le Token
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end