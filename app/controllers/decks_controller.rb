before "/decks/*" do
  current_user
end

get '/decks' do
  @decks = Deck.order('created_at DESC')
  erb :"decks/index"
end

get '/decks/:id' do
  @deck = Deck.find(params[:id])
  @round = @current_user.rounds.where(deck_id: @deck.id).first_or_create

  if @round.game_over?
    @message = "Deck finished!"
    erb :"decks/show"
  end

  if @round
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
  round = @current_user.rounds.find(params[:id])
  guess = round.guesses.build(card_id: @card.id)

  user_guess = params[:guess]

  if user_guess == @card.answer
    guess.set_correct
    round.increase_correct
    @deck.remove_card(@card.id)
    @message = "You got it right!"
  else
    round.increase_wrong
    @message = "Oops! The answer was:"
  end
  redirect "decks/#{@deck.id}"
end
