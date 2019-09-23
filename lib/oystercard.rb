# frozen_string_literal: true

class Oystercard
  attr_accessor :balance, :in_journey

  MAX_BALANCE = 90
  MIN_FARE = 1 #min_fare would be equivalent to min_balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance is #{MAX_BALANCE}." if over_maximum?(amount)

    self.balance += amount
  end

  def touch_in
    raise "Insufficient funds to travel." if insufficient_balance?

    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
    deduct(MIN_FARE)
  end

  def in_journey?
    in_journey
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
end
