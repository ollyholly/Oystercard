# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:max_balance) { Oystercard::MAX_BALANCE }
  let(:min_fare) { Oystercard::MIN_FARE }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  # let(:journey){ {entry: entry_station, exit: exit_station} }
  let(:journey) { double(:journey, entry_station: nil, exit_station: nil) }
  describe '#initialize' do
    it 'initialized with balance of 0' do
      expect(card.balance).to eq 0
    end

    it 'initializes with empty list of journeys' do
      expect(card.journey_list).to be_empty
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

    it 'raises an error when balance is below #{min_fare}' do
      message = 'Insufficient funds to travel.'
      expect { card.touch_in(entry_station) }.to raise_error message
    end

    it 'records an entry station' do
      card.top_up(min_fare)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
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

  # describe '#journeys' do
  #   before do
  #     card.top_up(10)
  #   end

  #   it 'touching in and out return one journey' do
  #     card.touch_in(entry_station)
  #     card.touch_out(exit_station)
  #     # allow(journey).to receive(:entry_station).with(entry_station)
  #     # allow(journey).to receive(:exit_station).with(entry_station)
  #     expect(card.journey).to eq journey
  #   end

  #   it 'returns a list of journeys' do
  #     subject.touch_in(entry_station)
  #     subject.touch_out(exit_station)
  #     # allow(journey).to receive(:entry_station).with(entry_station)
  #     # allow(journey).to receive(:exit_station).with(entry_station)
  #     expect(subject.journey_list).to include journey
  #   end
  # end
end
