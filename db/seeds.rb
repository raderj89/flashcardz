
our_deck = Deck.create(name: "States and Capitals")
File.readlines("./decks/states_and_capitals.txt").each_slice(2) do |pair|
  card = Card.create(question: pair[0].chomp, answer: pair[1].chomp, deck_id: our_deck.id)
end

User.create(email: "raderj89@gmail.com", password: "password")
