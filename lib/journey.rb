# frozen_string_literal: true

class Journey
  attr_accessor :entry_station, :exit_station

  MIN_FARE = 1
  MAX_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def calc_fare
    return MIN_FARE unless incomplete?

    MAX_FARE
  end

  private

  def incomplete?
    entry_station.nil? || exit_station.nil?
  end
end
