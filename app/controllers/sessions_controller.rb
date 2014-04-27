get "/login" do
  erb :"sessions/login"
end

post "/login" do
  user = User.find_by_email(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    redirect "/decks"
  else
    erb :"sessions/login"
  end
end

get '/logout' do
  session.clear
  redirect "/"
end
