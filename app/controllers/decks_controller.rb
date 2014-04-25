get '/decks' do
  @decks = Deck.order('created_at DESC')
  erb :"decks/index"
end
