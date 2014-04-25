get '/decks' do
  @decks = Deck.order('created_at DESC')
  erb :"decks/index"
end

get '/decks/1' do
  @deck = Deck.find(1)
  @round = Round.new(deck_id: @deck.id)
  @cards = @deck.cards
  erb :"decks/show"
end

post '/decks/1' do
  puts "#{params[:guess]}"
  @deck = Deck.find(1)
  @cards = @deck.cards
  @guess = params[:guess]
  erb :"decks/show"
end
