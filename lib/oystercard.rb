# frozen_string_literal: true

class Oystercard
  attr_accessor :balance, :in_journey

  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance is #{MAX_BALANCE}." if over_maximum?(amount)

    self.balance += amount
  end

  def deduct(amount)
    # raise "Maximum balance is #{MAX_BALANCE}." if over_maximum?(amount)

    self.balance -= amount
  end

  def touch_in
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
  end

  def in_journey?
    in_journey
  end

  private

  def over_maximum?(amount)
    self.balance + amount > MAX_BALANCE
  end
end
