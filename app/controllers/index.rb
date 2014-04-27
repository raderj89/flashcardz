before '/*' do
  current_user
end

get '/' do
  erb :index
end
