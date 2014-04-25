get "/login" do
  erb :"sessions/login"
end

post "/login" do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect "/decks"
    #eventual redirect to cards page
  else
    redirect '/login'
  end
end

get '/logout' do
  session.clear
  redirect "/"
end
