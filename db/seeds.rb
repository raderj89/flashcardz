
states_and_capitals_deck = Deck.create(name: "States and Capitals")
File.readlines("./decks/states_and_capitals.txt").each_slice(2) do |pair|
  card = Card.create(question: pair[0].chomp, answer: pair[1].chomp, deck_id: states_and_capitals_deck.id, image_url: "http://go4quiz.com/images/Map_of_USA_with_state_names.png")
end

User.create(email: "raderj89@gmail.com", password: "password")

english_to_hawaiian_deck = Deck.create(name: "English to Hawaiian")
File.readlines("./decks/english-hawaiian.txt").each_slice(2) do |pair|
  card = Card.create(question: pair[0].chomp, answer: pair[1].chomp, deck_id: english_to_hawaiian_deck.id, image_url: "http://images.fineartamerica.com/images-medium-large/-sunset-surf-marco-petracci.jpg")
end

