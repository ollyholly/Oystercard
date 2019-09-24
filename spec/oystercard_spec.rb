# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:max_balance) { Oystercard::MAX_BALANCE }
  let(:min_fare) { Oystercard::MIN_FARE }
  let(:station_name) { double(:station_name) }
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

  describe '#touch_in' do
    it 'sets the card to be in journey' do
      card.top_up(min_fare * 2)
      card.touch_in(station_name)
      expect(card).to be_in_journey
    end

    it 'raises an error when balance is below #{min_fare}' do
      message = 'Insufficient funds to travel.'
      expect { card.touch_in(station_name) }.to raise_error message
    end

    it 'records an entry station' do
      card.top_up(min_fare)
      card.touch_in(station_name)
      expect(card.entry_station).to eq station_name
    end
  end

  describe '#touch_out' do
    it 'sets the card to be not in journey' do
      card.touch_out
      expect(card).not_to be_in_journey
    end

    it 'deducts minimum fare from balance' do
      card.top_up(10)
      card.touch_in(station_name)
      expect { card.touch_out }.to change { card.balance }.by -min_fare
    end

    it 'set entry station to nil' do
      card.top_up(min_fare)
      card.touch_in(station_name)
      card.touch_out

      expect(card.entry_station).to eq nil

    end
  end
end
