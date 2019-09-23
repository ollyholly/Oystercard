# frozen_string_literal: true

class Oystercard
  attr_accessor :balance

  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    if self.balance + amount > MAX_BALANCE
      fail "Maximum balance is #{MAX_BALANCE}."
    end
    
    self.balance += amount
  end
end
