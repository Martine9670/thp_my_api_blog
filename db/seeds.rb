# On n'oublie pas d'ajouter 'faker' dans le Gemfile si besoin
puts "Nettoyage de la base..."
Article.destroy_all

puts "Création de 30 articles..."
30.times do
  Article.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5)
  )
end
puts "Terminé !"