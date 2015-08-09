require 'sinatra'
require 'data_mapper'
require 'json'

set :bind, '0.0.0.0'
set :port, '3000'
set :environment, :production

DB_PASS = ENV['DB_ENV_DB_PASS']
DB_USER = ENV['DB_ENV_DB_USER']
DB_NAME = ENV['DB_ENV_DB_NAME']

DataMapper.setup(:default, "postgres://#{DB_USER}:#{DB_PASS}@db/#{DB_NAME}")

class User
  include DataMapper::Resource

  property :id,   Serial
  property :name, Text
end

post '/users' do
  response = {}
  if User.create(name: params['name'])
    response[:status]  = 'success'
    response[:message] = 'User added successfully'
  else
    response[:status]  = 'fail'
    response[:message] = 'Can\'t add user.'
  end
  response.to_json
end

get '/users' do
  users = User.all.map(&:name)
  response = { data: {} } 
  if users.empty?
    response[:status]  = 'fail'
    response[:message] = 'Users list is empty.'
  else
    response[:status] = 'success'
    response[:data][:users] = users
  end
  response.to_json 
end

get '/env' do
  {
    status: 'success',
    data: {
      db_user: DB_USER,
      db_pass: DB_PASS,
      db_name: DB_NAME
    }
  }.to_json
end

DataMapper.finalize.auto_upgrade!
