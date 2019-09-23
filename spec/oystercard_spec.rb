# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:max_balance) { Oystercard::MAX_BALANCE }

  describe '#initialize' do

    it 'initialized with balance of 0' do
      expect(card.balance).to eq 0
    end

    it 'initializes not in journey' do
      expect(card).not_to be_in_journey
    end

  end

  describe '#top_up' do
    it 'adds money to the card' do
      card.top_up(10)
      expect(card.balance).to eq 10
    end
    it 'raises an error when trying to top up and balance goes over #{max_balance}' do
      card.top_up(max_balance)
      message = "Maximum balance is #{max_balance}."
      expect { card.top_up(1) }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'deducts money to the card' do
      card.top_up(10)
      expect { card.deduct(5) }.to change { card.balance }.by -5
    end
  end
  
  describe '#touch_in' do
    
    it 'sets the card to be in journey' do
      card.touch_in
      expect(card).to be_in_journey
    end

  end
  
  describe '#touch_out' do
    it 'sets the card to be not in journey' do
      card.touch_out
      expect(card).not_to be_in_journey
    end
  end
  
end
