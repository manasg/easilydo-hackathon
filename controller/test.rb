require 'rubygems'
require 'aws-sdk'

remove_instance_id = 'i-0c502462'
lb_id = 'hackathon-lb'

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


