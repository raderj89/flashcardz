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
    if request.xhr?
      @card = @deck.choose_card
      { card: @card }.to_json
    else
      @card = @deck.choose_card
      erb :"decks/show"
    end
  else
    redirect back
  end
end

post '/decks/:id' do
  @deck = Deck.find(params[:id])
  @card = @deck.cards.find(params[:card_id])

  round = @current_user.rounds.where(deck_id: params[:id]).first
  guess = round.guesses.build(card_id: @card.id)

  user_guess = params[:guess]

  if guess.save
    if request.xhr?
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
    else
      if user_guess == @card.answer
        guess.set_correct
        round.increase_correct
        @message = "You got it right!"
      else
        round.increase_wrong
        @message = "Oops! The answer was: #{@card.answer}"
      end
    end
  else
    flash[:danger] = "There was a problem saving your guess."
    redirect back
  end
end

get "/upload" do
  erb :"decks/new"
end

post "/upload" do
  File.open('../decks/' + params[:deck][:filename], "w") do |f|
    f.write(params[:deck][:tempfile].read)
  end

  deck = Deck.create(name: params[:name])

  cards = File.readlines('../decks/' + params[:deck][:filename])

  cards.each_slice(2) do |pair|
    card = Card.create(question: pair.first.chomp, answer: pair.last.chomp, deck_id: deck.id)
  end

  flash[:success] = "The file was successfully uploaded!"
  redirect "/decks"
end
