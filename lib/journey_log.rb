# frozen_string_literal: true

require_relative 'journey'

class JourneyLog
  attr_accessor :journey_list

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @journey_list = []
  end

  def start(station)
    current_journey.start(station)
  end

  def finish(station)
    current_journey.end(station)
    finalise_journey
  end

  def fare
    journey_list.last.calc_fare
  end

  def in_journey?
    !!@current_journey
  end

  def finalise_journey
    @journey_list << current_journey
    @current_journey = nil
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end
end
