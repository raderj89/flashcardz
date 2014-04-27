get "/login" do
  if logged_in?
    flash[:warning] = "You are already logged in."
    redirect "/profile"
  else
    erb :"sessions/login"
  end
end

post "/login" do
  user = User.find_by_email(params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user_id] = user.id
    redirect "/decks"
  else
    flash[:danger] = "Your email or password is incorrect. Please try again."
    redirect back
  end
end

get '/logout' do
  session.clear
  redirect "/"
end
