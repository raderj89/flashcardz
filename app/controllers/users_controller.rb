get "/register" do
  if logged_in?
    flash[:warning] = "You already have an account."
    redirect "/profile"
  else
    erb :"users/register"
  end
end

post "/register" do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/decks'
  else
    erb :"users/register"
  end
end

get "/profile" do
  @user = current_user

  if @user
    @user.rounds.order('created_at DESC')
    erb :"users/profile"
  else
    flash[:danger] = "Please sign up."
    redirect back
  end
end
