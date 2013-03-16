require 'rubygems'
require 'sinatra'

set :port, 80
set :bind, '0.0.0.0'

get "/" do
    "Hi as usual! You can count on me!"
end
