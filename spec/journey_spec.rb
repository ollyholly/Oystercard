# frozen_string_literal: true

require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double :station }

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
      journey.entry_station = station
      journey.exit_station = station

      expect(journey.calc_fare).to eq 1
    end

    it 'calculate incomplete journey with penalty for not touching out' do
      journey.entry_station = station
      expect(journey.calc_fare).to eq 6
    end

    it 'calculate incomplete journey with penalty for not touching in' do
      journey.exit_station = station
      expect(journey.calc_fare).to eq 6
    end
  end

  # it 'set entry station to nil' do
  #   card.top_up(min_fare)
  #   card.touch_in(entry_station)
  #   card.touch_out(exit_station)

  #   expect(card.entry_station).to eq nil
  # end
end
