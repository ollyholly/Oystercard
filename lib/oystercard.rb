# frozen_string_literal: true

class Oystercard
  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    self.balance += amount
  end
end
