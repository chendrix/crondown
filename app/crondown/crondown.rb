module Crondown
  DELIMITERS = %w(, /)

  def self.next_event(events)
    # Chronic has a weird bug where "next friday" parses to noon?
    # And "next friday at midnight" parses to midnight of the next day?
    # So instead get it 1 second after midnight
    next_events = events.map { |event| Chronic.parse("next #{event} at 00:00:01AM") }

    yield next_events.sort.first
  end

  def self.next_event_from_params(params, &block)
    events = Crondown::DELIMITERS.inject(params['captures']) do |intermediate_events, delimiter|
      intermediate_events.flat_map { |cap| cap.split(delimiter) }
    end

    self.next_event(events, &block)
  end
end
