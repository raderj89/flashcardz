
require 'pry-rails'

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
  elsif @round
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
