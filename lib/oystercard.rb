# frozen_string_literal: true

class Oystercard
  attr_accessor :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance is #{MAX_BALANCE}." if over_maximum?(amount)

    self.balance += amount
  end

  private

  def over_maximum?(amount)
    self.balance + amount > MAX_BALANCE
  end
end
