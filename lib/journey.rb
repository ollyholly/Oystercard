# frozen_string_literal: true

class Journey
  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def calc_fare
    return Oystercard::MAX_FARE if incomplete?

    Oystercard::MIN_FARE
  end

  private

  def incomplete?
    entry_station.nil? || exit_station.nil?
  end
end
