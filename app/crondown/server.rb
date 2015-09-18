require 'active_support/all'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/json'
require 'chronic'
require 'json'
require 'slim'

require 'crondown/crondown'

Time.zone = 'America/Los_Angeles'
Chronic.time_class = Time.zone

module Crondown
  class Server < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    get '/*.json' do
      Crondown.next_event_from_params(params) do |time|
        json seconds_until_next_event: (time - DateTime.current)
      end
    end

    get '/*' do
      Crondown.next_event_from_params(params) do |time|
        slim :index, locals: {seconds_until_next_event: (time - DateTime.current)}
      end
    end
  end
end