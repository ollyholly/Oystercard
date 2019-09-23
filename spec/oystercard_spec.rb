require 'oystercard'

describe Oystercard do

    describe '#balance' do
      it 'initialized with balance of 0' do
      expect(subject.balance).to eq 0
      end
    end
end
