before "/decks/*" do
  current_user
end

get '/decks' do
  @decks = Deck.order('created_at DESC')
  erb :"decks/index"
end

get '/decks/:id' do
  @deck = Deck.find(params[:id])
  @round = @current_user.rounds.build(deck_id: @deck.id)

  if @round.save
    @card = @deck.choose_card
    erb :"decks/show"
  else
    redirect back
  end
end

post '/decks/:id' do
  puts "#{params}"
  @deck = Deck.find(params[:id])
  @card = Card.find(params[:card_id])
  @round = @current_user.rounds.find(params[:id])
  @guess = @round.guesses.build

  user_guess = params[:guess]

  if user_guess == @card.answer
    @guess.correct = true
    @round.increase_correct

  else
    @round.increase_wrong
  end
  erb :"decks/show"
end
