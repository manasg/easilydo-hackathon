require 'rubygems'
require 'sinatra'

set :port, 2001

def be_slow 
    # current time, if second is even - be slow!
    return (Time.now.sec % 2 == 0)
end

get "/" do
    if be_slow 
        sleep 2
        "I am feeling slow"
    else
        "Hi as usual!"
    end
end
