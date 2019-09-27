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
    if incomplete?
      penalty
    else
      Oystercard::MIN_FARE + zone_charge
    end
  end

  private

  def incomplete?
    entry_station.nil? || exit_station.nil?
  end

  def zone_charge
    (entry_station.zone - exit_station.zone).abs
  end

  def penalty
    Oystercard::MAX_FARE
  end
end
