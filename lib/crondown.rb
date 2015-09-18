require 'sinatra/base'
require 'sinatra/json'
require 'chronic'
require 'json'
require 'pry'

class Crondown < Sinatra::Base
  get '/countdown_to/*' do
    delimiters = %w(, /)

    events = delimiters.inject(params['captures']) do |intermediate_events, delimiter|
      intermediate_events.flat_map { |cap| cap.split(delimiter) }
    end

    next_events = events.map { |event| Chronic.parse("next #{event}") }

    json :next_event => next_events.sort.first
  end
end