require 'sinatra/base'
require 'sinatra/json'
require 'chronic'
require 'json'
require 'slim'

require 'crondown/crondown'

module Crondown
  class Server < Sinatra::Base
    get '/*.json' do
      Crondown.next_event_from_params(params) do |time|
        json seconds_until_next_event: time
      end
    end

    get '/*' do
      Crondown.next_event_from_params(params) do |time|
        slim :index, locals: {seconds_until_next_event: (time - Time.now)}
      end
    end
  end
end