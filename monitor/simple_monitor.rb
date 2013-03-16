require "net/http"
require "uri"

INTERVAL_SEC = 2.0 + (1 * rand)

alert_threshold_sec = 1.5

endpoints = %w{ http://localhost:4567/ }

def fetch_url(url)
    uri = URI.parse(URI.encode(url.strip))
    Net::HTTP.get_response(uri)
end

def alert(url, resp_time)
    puts "#{Time.now} oh no! This #{url} took #{resp_time} seconds!"
end

loop {
    endpoints.each do |url|
        begin_time = Time.now
        resp = fetch_url(url)
        end_time = Time.now

        resp_time = end_time - begin_time
        
        if resp_time > alert_threshold_sec
            alert(url, resp_time)
        else
            puts "#{Time.now} This URL #{url} took #{resp_time} seconds"
        end
    end

    sleep INTERVAL_SEC
}

