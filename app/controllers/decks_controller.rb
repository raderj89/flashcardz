get '/decks' do
  if logged_in?
    @decks = Deck.order('created_at DESC')
    erb :"decks/index"
  else
    flash[:danger] = "You need to be signed in to view decks."
    redirect "/"
  end
end

get '/decks/:id' do
  if logged_in?
    @deck = Deck.find(params[:id])
    @round = @current_user.rounds.where(user_id: @current_user.id, deck_id: @deck.id).first_or_create
  else
    flash[:danger] = "You need to be signed in to play a round."
    redirect "/"
  end

  if @round.game_over?
    @message = "Deck finished!"
    erb :"decks/show"
  elsif @round
    @card = @deck.choose_card
    erb :"decks/show"
  else
    redirect back
  end

end

post '/decks/:id' do
  @deck = Deck.find(params[:id])
  @card = Card.find(params[:card_id])

  round = @current_user.rounds.find(params[:id])
  guess = round.guesses.build(card_id: @card.id)

  user_guess = params[:guess]

  if user_guess == @card.answer
    guess.set_correct
    round.increase_correct
    response = "You got it right!"
  else
    round.increase_wrong
    response = "Oops! The answer was: #{@card.answer}"
  end
  { num_correct: round.num_correct,
    num_wrong: round.num_wrong,
    response: response,
    num_left: round.cards_left }.to_json
end
