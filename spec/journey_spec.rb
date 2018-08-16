require 'journey'

describe Journey do

  entry_station = "Victoria"
  exit_station = "Aldgate"
  
  
  subject { described_class.new(entry_station, exit_station) }
  
  
  describe "#entry_station and #exit_station" do
    it "returns entry station" do
      expect(subject.entry_station).to eq entry_station
    end
    it "returns exit station" do
      expect(subject.exit_station).to eq exit_station
    end
  end



end
