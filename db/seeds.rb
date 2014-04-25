
our_deck = Deck.create(name: "States and Capitals")
File.readlines("./decks/states_and_capitals.txt").each_slice(2) do |pair|
  card = Card.create(question: pair[0], answer: pair[1], deck_id: our_deck.id)
end

