# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:max_balance) { Oystercard::MAX_BALANCE }
  let(:min_fare) { Oystercard::MIN_FARE }
  let(:entry_station) { double :station, name: 'Apple', zone: 1 }
  let(:exit_station) { double :station, name: 'Banana', zone: 1 }
  let(:journey) { double(:journey, entry_station: nil, exit_station: nil) }
  let(:journey_log) { double :journey_log }

  describe '#initialize' do
    it 'initialized with balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'adds money to the card' do
      card.top_up(10)
      expect(card.balance).to eq 10
    end
    it 'raises an error when trying to top up and balance goes over maximum balance' do
      card.top_up(max_balance)
      message = "Maximum balance is #{max_balance}."
      expect { card.top_up(1) }.to raise_error message
    end
  end

  describe '#touch_in' do
    it 'raises an error when balance is below minimum fare' do
      message = 'Insufficient funds to travel.'
      expect { card.touch_in(entry_station) }.to raise_error message
    end

    it 'touching in twice will charge the £6 penalty fare' do
      card.top_up(30)
      card.touch_in(entry_station)
      expect { card.touch_in(entry_station) }.to change { card.balance }.by -6
    end
  end

  describe '#touch_out' do
    it 'deducts minimum fare from balance' do
      card.top_up(10)
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by -min_fare
    end
  end
end
