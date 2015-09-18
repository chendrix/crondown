module Crondown
  DELIMITERS = %w(, /)

  def self.next_event(events)
    next_events = events.map { |event| Chronic.parse("next #{event}") }

    yield next_events.sort.first
  end

  def self.next_event_from_params(params, &block)
    events = Crondown::DELIMITERS.inject(params['captures']) do |intermediate_events, delimiter|
      intermediate_events.flat_map { |cap| cap.split(delimiter) }
    end

    self.next_event(events, &block)
  end
end