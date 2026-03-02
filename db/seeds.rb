# On nettoie pour repartir sur du propre
puts "Nettoyage de la base..."
Article.destroy_all
User.destroy_all

# 1. On crée Martine (obligatoire pour lier les articles)
puts "Création de l'utilisateur..."
martine = User.create!(
  email: 'martine@exemple.com', 
  password: 'password', 
  password_confirmation: 'password'
)

# 2. On crée les articles liés à Martine
puts "Génération de 30 articles API..."
30.times do
  Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5),
    user: martine # <-- C'est LA ligne cruciale pour ne pas avoir d'erreur !
  )
end

puts "Succès ! 1 user et 30 articles créés."