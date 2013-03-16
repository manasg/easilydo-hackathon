require 'rubygems'
require 'sinatra'

set :port, 5001

post "/remove_from_elb/:instance_id" do
    "Received request to remove #{instance_id} from ELB"    
end
