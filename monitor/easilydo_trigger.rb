require 'rubygems'
require 'json'
require 'base64'
require 'net/http'
require 'net/https'
require 'uri'

require "pp"

class EasilydoTrigger
    @@post_task_url = "https://agent8-backend-staging.appspot.com/hackathon/discovery/postTask"
    @@do_type = 5521
    @@username = 'manas@easilydo.com'

    def construct_payload(id, url)
        payload = {}
        payload['doType'] = @@do_type
        payload['doResponse'] = [{'userName' => @@username,
                                    'uniqueId' => Base64.encode64("something#{Time.now}").gsub(/\n/, ''),
                                    'variables' => {
                                        'instance_id' => "#{id}",
                                        'server_name' => "#{url}"
                                    }
                            }]
        payload
    end

    def post_payload(payload) 
        uri = URI.parse(@@post_task_url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        
        request = Net::HTTP::Post.new(uri.request_uri,initheader = {'Content-Type' =>'application/json'})
        request.body = payload.to_json
        response = http.request(request)
    end
end

#t =  EasilydoTrigger.new
#payload = t.construct_payload('id-te','hfsd')
#pp payload
#pp t.post_payload(payload)


