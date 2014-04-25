get "/register" do
  erb :"users/register"
end

post "/register" do
  @user = User.new(email: params[:email], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/register'
    # add errors eventually
    @errors = nil
  end
end
