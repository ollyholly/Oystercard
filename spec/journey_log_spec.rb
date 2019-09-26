# frozen_string_literal: true

require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new(:journey_class, journey_class) }
  let(:station) { double :station }
  let(:journey) { double :journey }
  let(:journey_class) { double(:journey_class, new: journey) }

  describe '#start' do
    it 'start a new journey' do
      expect(journey_class).to receive(:new).with(entry_station: station)
      journey_log.start(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      journey_log.start(station)
      expect(journey_log).to include journey
    end
  end

  # start
  # current journey
  # journeys
  # finish
end
