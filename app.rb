require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'postgres://localhost/sinatra_test')

class Comment
  include DataMapper::Resource

  property :id,   Serial
  property :body, Text
end

set :bind, '0.0.0.0'
set :port, '3000'

post '/comments' do
  Comment.create(body: params['body'])
end

get '/comments' do
  Comment.all.map(&:body).join(',')
end

DataMapper.finalize.auto_upgrade!
