# frozen_string_literal: true

require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_accessor :balance, :entry_station, :journey_list, :journey

  MAX_BALANCE = 90
  MIN_FARE = 1
  MAX_FARE = 6

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_list = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum balance is #{MAX_BALANCE}." if over_maximum?(amount)

    self.balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds to travel.' if insufficient_balance?

    double_tap_in if @journey.entry_station != nil
    self.entry_station = station
    journey.entry_station = station
  end

  def touch_out(station)
    journey.exit_station = station
    deduct(@journey.calc_fare)
    journey_list << journey
    @journey = Journey.new
  end

  def in_journey?
    !entry_station.nil?
  end

  private

  def deduct(amount)
    self.balance -= amount
  end

  def insufficient_balance?
    self.balance < MIN_FARE
  end

  def over_maximum?(amount)
    self.balance + amount > MAX_BALANCE
  end

  def double_tap_in
    deduct(@journey.calc_fare)
    @journey_list << @journey
    @journey = Journey.new
  end
end
