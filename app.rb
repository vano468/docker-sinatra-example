require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'postgres://localhost/sinatra_test')

class User
  include DataMapper::Resource

  property :id,   Serial
  property :name, Text
end

set :bind, '0.0.0.0'
set :port, '3000'

post '/users' do
  User.create(name: params['name'])
end

get '/users' do
  User.all.map(&:name).join(',')
end

DataMapper.finalize.auto_upgrade!
