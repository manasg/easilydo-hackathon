require 'rubygems'
require 'sinatra'
require 'json'
require 'pp'

set :port, 80
set :bind, '0.0.0.0'

#TODO : auth!

get "/" do
    "This is the control server"
end

post "/remove_from_elb" do
    data = JSON.parse(request.body.read)
    "kthnkxbye!" unless data
    pp data
    instance_id = data['instance_id']
    puts "Received request to remove #{instance_id} from ELB"
end

get "/test" do
    "Nothing here. Try posting"
end

post "/test" do
    data = JSON.parse(request.body.read)
    pp data
    "cool..thanks!"
end
