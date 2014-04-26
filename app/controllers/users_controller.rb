get "/register" do
  erb :"users/register"
end

post "/register" do
  @user = User.new(email: params[:email], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect '/decks'
  else
    redirect '/register'
    # add errors eventually
    @errors = nil
  end
end

get "/profile" do
  @user = current_user

  if @user
    @user.rounds.order('created_at DESC')
    erb :"users/profile"
  else
    redirect back
  end
end
