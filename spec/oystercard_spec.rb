# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  subject (:card) { described_class.new }

  describe '#balance' do
    it 'initialized with balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds money to the card' do
      card.top_up(10)
      expect(card.balance).to eq 10
    end
  end
end
