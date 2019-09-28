# frozen_string_literal: true

class JourneyLog
  attr_reader :journey_class, :journey_list
  attr_accessor :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_list = []
    @current_journey = journey_class.new
  end

  def start(station)
    current_journey.start(station)
  end

  def finish(station)
    current_journey.end(station)
  end

  def fare
    journey_list.last.calc_fare
  end

  def in_journey?
    !current_journey.entry_station.nil? || !current_journey.exit_station.nil?
  end

  def finalise_journey
    @journey_list << current_journey
    @current_journey = journey_class.new
  end
end
