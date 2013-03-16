require 'rubygems'
require 'sinatra'
require 'json'

set :port, 80
set :bind, '0.0.0.0'

#TODO : auth!

get "/" do
    "This is the control server"
end

post "/remove_from_elb/:instance_id" do
    "Received request to remove #{instance_id} from ELB"    
end

get "/test" do
    "Nothing here. Try posting"
end

post "/test" do
    data = JSON.parse(request.body.read)
    puts data
    "cool..thanks!"
end
