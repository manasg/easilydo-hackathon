require "net/http"
require "uri"
require "pp"

INTERVAL_SEC = 1.0 + (1 * rand)

alert_threshold_sec = 1.5

iterations = 15

endpoints = %w{ http://localhost:2001/ http://localhost:2002/ }

@asked_human = {}

history = {}
alarm_history = {}

endpoints.each do |url| 
    history[url] = []
    alarm_history[url] = []
    @asked_human[url] = false
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

def alert(url, resp_time)
    puts "#{Time.now} oh no! This #{url} took #{resp_time} seconds!"
end

def ask_human(url)
    if @asked_human[url]
        puts "not asking as we have already asked" 
    else
        puts "asking human! #{url} is flapping"
        @asked_human[url] = true
    end
end

def test_state_change
    a = %w{ T F T F F }
    raise "failed" if flapping(a)
    raise "failed" unless flapping(a, last_n=5)
end


iterations.times do 
    endpoints.each do |url|
        alarm = false
        begin_time = Time.now
        resp = fetch_url(url)
        end_time = Time.now

        resp_time = end_time - begin_time
        
        history[url] << resp_time 

        alarm = true if resp_time > alert_threshold_sec
        
        alarm_history[url] << alarm

        if alarm
            alert(url, resp_time)
        else
            puts "#{Time.now} This URL #{url} took #{resp_time} seconds"
        end
    
        if flapping(alarm_history[url])
            ask_human(url)
        end
    
    end

    sleep INTERVAL_SEC
end

pp history
pp alarm_history
