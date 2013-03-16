require 'rubygems'
require 'sinatra'

set :port, 80
set :bind, '0.0.0.0'

#TODO : auth!

get "/" do
    "This is the control server"
end

post "/remove_from_elb/:instance_id" do
    "Received request to remove #{instance_id} from ELB"    
end

post "/test" do
    puts params
end
