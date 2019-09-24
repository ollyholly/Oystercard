require 'station'

describe Station do
  it { is_expected.to respond_to(:zone) }
  subject(:station) { described_class.new(name: "Aldgate East", zone: 1) }

  describe '#initialize' do
    it 'expects station to initialize with name' do
      expect(station.name).to eq "Aldgate East"
    end

    it 'expects station to initialize with zone' do
      expect(station.zone).to eq 1
    end
  end
end
