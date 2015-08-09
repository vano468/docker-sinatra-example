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
  User.create(name: params['name'])
end

get '/users' do
  User.all.map(&:name).join(',')
end

get '/status' do
  'Hello World!!!'
end

DataMapper.finalize.auto_upgrade!
