# frozen_string_literal: true

require 'oystercard'
require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double :station }
  let(:station1) { double :station, name: 'Apple', zone: 1 }
  let(:station2) { double :station, name: 'Banana', zone: 1 }
  let(:station3) { double :station, name: 'Cherry', zone: 3 }
  let(:max_fare) { Oystercard::MAX_FARE }
  let(:min_fare) { Oystercard::MIN_FARE }

  describe '#initialize' do
    it 'is initialized with nil values for entry and exit' do
      expect(journey.entry_station).to eq nil
      expect(journey.exit_station).to eq nil
    end
  end

  describe '#entry_station' do
    it 'sets entry station' do
      journey.entry_station = station
      expect(journey.entry_station).to eq station
    end
  end

  describe '#exit_station' do
    it 'sets exit station' do
      journey.exit_station = station
      expect(journey.exit_station).to eq station
    end
  end

  describe '#calc_fare' do
    it 'calculate fare for a normal journey' do
      journey.entry_station = station1
      journey.exit_station = station2

      expect(journey.calc_fare).to eq min_fare
    end

    it 'calculate incomplete journey with penalty for not touching out' do
      journey.entry_station = station
      expect(journey.calc_fare).to eq max_fare
    end

    it 'calculate incomplete journey with penalty for not touching in' do
      journey.exit_station = station
      expect(journey.calc_fare).to eq max_fare
    end

    it 'calculate fare traveling within the same zone' do
      journey.start(station1)
      journey.end(station2)
      expect(journey.calc_fare).to eq 1
    end

    it 'calculate fare traveling within different zones' do
      journey.start(station1)
      journey.end(station3)
      expect(journey.calc_fare).to eq 3
    end
  end
end
