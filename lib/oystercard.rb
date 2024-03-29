# frozen_string_literal: true

require_relative 'journey_log'
require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_log

  MAX_BALANCE = 90
  MIN_FARE = 1
  MAX_FARE = 6

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "Maximum balance is #{MAX_BALANCE}." if over_maximum?(amount)

    @balance += amount
  end

  def touch_in(station)
    charge if in_journey?
    raise 'Insufficient funds to travel.' if insufficient_balance?

    journey_log.start(station)
  end

  def touch_out(station)
    journey_log.finish(station)
    charge
  end

  private

  def charge
    journey_log.finalise_journey
    deduct(journey_log.fare)
  end

  def deduct(amount)
    @balance -= amount
  end

  def insufficient_balance?
    balance < MIN_FARE
  end

  def over_maximum?(amount)
    balance + amount > MAX_BALANCE
  end

  def in_journey?
    journey_log.in_journey?
  end
end
