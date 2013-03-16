require 'rubygems'
require 'sinatra'
require 'json'
require 'pp'

require 'rubygems'
require 'aws-sdk'

set :port, 80
set :bind, '0.0.0.0'

#TODO : auth!

elb = ''

def remove_instance_elb(remove_instance_id, lb_id='hackathon-lb')
    elb = AWS::ELB.new
    lbs = elb.load_balancers

    lb = lbs[lb_id]
    instances = lb.instances

    puts "Current instances in LB #{lb_id}"
    instances.each {|i| puts i.instance_id}

    instances.each do |i|
        if remove_instance_id == i.instance_id
            i.remove_from_load_balancer()
            puts "Deleted #{remove_instance_id}"
        end
    end

    puts "Current instances in LB #{lb_id}"
    instances.each {|i| puts i.instance_id}
end

get "/" do
    "This is the control server"
end

post "/remove_from_elb" do
    data = JSON.parse(request.body.read)
    "kthnkxbye!" unless data
    pp data
    payload = data['params']
    instance_id = payload['instance_id']
    puts "Received request to remove #{instance_id} from ELB"
    remove_instance_elb(instance_id)
end

get "/test" do
    "Nothing here. Try posting"
end

post "/test" do
    data = JSON.parse(request.body.read)
    pp data
    "cool..thanks!"
end
