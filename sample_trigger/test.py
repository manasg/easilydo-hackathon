import os
import base64
import requests
import json

POST_TASK_URL = "https://agent8-backend-staging.appspot.com/hackathon/discovery/postTask"

def run(request=None):
    # Handle the request

    # Discovery algorithms go here, 
    # such as discovering if you have recently added a new friend in Facebook

    # POST data from trigger code to Do-Engine
    payload = {
                "doType" : 5505, # ID of the Trigger in EasilyDo Builder
                "doResponse" : [{
                    "userName" : "manas@easilydo.com", # EasilyDo user name
                    "uniqueId" : base64.urlsafe_b64encode(os.urandom(30)), 
                    "variables" : {
                        "instance_id" : "i-test1234",
                        "server_name" : "webserver-LUFT"
                        }
                    }]  
                }
    r = requests.post(POST_TASK_URL, data=json.dumps(payload))
    print r
    print 'Found new friend, hello EasilyDo'
    return True
    

if __name__ == '__main__':
    run()
