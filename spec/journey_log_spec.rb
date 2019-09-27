# frozen_string_literal: true

require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new }
  let(:journey_class) { double :journey_class, new: journey }

  let(:journey_log) { described_class.new(current_journey) }
  let(:current_journey) { double :current_journey, new: journey }
  let(:journey) { double :journey, entry_station: nil, exit_station: nil }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'initializes with a journey' do
    expect(journey_log.current_journey).to eq journey
  end

  it 'initialzes with no stored journeys' do
    expect(journey_log.journey_list).to be_empty
  end

  describe '#start' do
    it 'starts the current journey' do
      expect(journey).to receive(:start).with(entry_station)
      journey_log.start(entry_station)
    end
  end

  describe '#finish' do
    it 'finishes the current journey' do
      expect(journey).to receive(:end).with(exit_station)
      journey_log.finish(exit_station)
    end
  end

  describe '#journey_history' do
  end

  # resets current journey
  describe '#finalise_journey' do
    it 'adds the journey to a journey list' do
      allow(journey).to receive(:start).with(entry_station)
      allow(journey).to receive(:end).with(exit_station)
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      expect(journey_log.journey_list).to include journey
    end

    it 'resets current journey so entry and exit stations are nil' do
      allow(journey).to receive(:start).with(entry_station)
      allow(journey).to receive(:end).with(exit_station)
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      expect(journey_log.current_journey).to eq journey
    end
  end

  # "calculates the charges of all incomplete journeys"
  # "closes incomplete journeys"
  # 'init an empty history if no journeys were completed'
end
