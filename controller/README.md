Sample controller 

Idea being that it can interact with your infrastructure via a set of recipes. 

For example - you could have a recipe which removes a given instance from the Load balancer in AWS.

Another example - rolling restart of services.

Controller actions would correspond to Easilydo Actions.

Setup:
These examples require sinatra and aws-sdk (via rubygems)

optional: for aws-sdk gem installation - you may need
sudo apt-get install ruby-dev
sudo apt-get install build-essential
sudo apt-get install libxslt-dev libxml2-dev

sudo gem install aws-sdk --no-ri --no-rdoc
sudo gem install json --no-ri --no-rdoc

