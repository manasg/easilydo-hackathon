require "net/http"
require "uri"
require "pp"
require 'easilydo_trigger'

INTERVAL_SEC = 1.0 + (1 * rand)

alert_threshold_sec = 1.5

iterations = 20

endpoints = [{ "id" => "i-0c502462", "url" => "http://ec2-184-72-70-153.compute-1.amazonaws.com/"},
                { "id" => "i-7a9f3a11", "url" => " http://ec2-54-224-54-120.compute-1.amazonaws.com/"  }
            ]

@asked_human = {}

history = {}
alarm_history = {}

endpoints.each do |e| 
    id = e['id']
    history[id] = []
    alarm_history[id] = []
    @asked_human[id] = false
end

def fetch_url(url)
    uri = URI.parse(URI.encode(url.strip))
    Net::HTTP.get_response(uri)
end

def flapping(alarm_history , last_n = 5, state_change_threshold = 2) 
    # Write your own logic here!
    # if there is a state change more than X times in the last n readings
    #last_n = 4
    #state_change_threshold = 2
    event_history = alarm_history
    
    return false if event_history.size < last_n

    state_change = 0

    event_history[-last_n..-2].each_with_index do |val, indx|
        state_change += 1  if val != event_history[indx+1]
    end

    state_change > state_change_threshold
end

def alert(id, url, resp_time)
    url = 
    puts "#{Time.now} oh no! This #{url} took #{resp_time} seconds!"
end

def ask_human(id,url)
    if @asked_human[id]
        puts "not asking as we have already asked" 
    else
        puts "asking human! #{url} on #{id} is flapping"
        t = EasilydoTrigger.new
	payload = t.construct_payload(id, url)
	t.post_payload(payload)
 
	@asked_human[id] = true
    end
end

def test_state_change
    a = %w{ T F T F F }
    raise "failed" if flapping(a)
    raise "failed" unless flapping(a, last_n=5)
end


iterations.times do 
    endpoints.each do |ep|
        id = ep['id']
        url = ep['url']

        alarm = false
        begin_time = Time.now
        resp = fetch_url(url)
        end_time = Time.now

        resp_time = end_time - begin_time
        
        history[id] << resp_time 

        alarm = true if resp_time > alert_threshold_sec
        
        alarm_history[id] << alarm

        if alarm
            alert(id, url, resp_time)
        else
            puts "#{Time.now} This URL #{url} took #{resp_time} seconds"
        end
    
        if flapping(alarm_history[id])
            ask_human(id,url)
        end
    
    end

    sleep INTERVAL_SEC
end

pp history
pp alarm_history
