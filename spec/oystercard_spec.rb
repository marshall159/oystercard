require "oystercard"

describe Oystercard do
#  let(:subject) { Oystercard.new }
  # it "it responds to #balance" do
  #   expect(subject).to respond_to(:balance)
  # end

  it "has initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it "responds to #top_up" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "adds amount to #balance" do
      card = Oystercard.new
      amount = 20
      card.top_up(amount)
      expect(card.balance).to eq(amount)
    end

    context "amount exceeds limit" do
      before(:context) do
        @card = Oystercard.new
        @card.top_up(90)
        @station = "Ealing"
      end

      it "raises an error" do
        expect{ @card.top_up(1) }.to raise_error("Limit of £#{Oystercard::MAX_BALANCE} exceeded")
      end
    end
  end

  context "minimum balance required" do
    it "raises an error" do
      expect{ subject.touch_in(@station) }.to raise_error("Minimum balance £#{Oystercard::MIN_BALANCE} required")
    end
  end

  context "top_up before journey" do
    before(:example) do
      @card = Oystercard.new
      @card.top_up(3)
      @entry_station = double(:ealing)
      @exit_station = double(:aldgate)
    end

    describe "touch_in and touch_out" do
      it "#in_journey? returns status" do
        expect(subject).not_to be_in_journey
        expect(subject.in_journey?).to be(false)
      end

      it "#touch_in changes status of #in_journey?" do
        expect { @card.touch_in(@entry_station) }.to change { @card.in_journey? }.from(false).to(true)
      end

      it "#touch_out changes status of #in_journey?" do
        @card.touch_in(@entry_station)
        expect { @card.touch_out(@exit_station) }.to change { @card.in_journey? }.from(true).to(false)
      end

      it "#touch_out reduces balance by minimum fare" do
        expect { @card.touch_out(@exit_station) }.to change { @card.balance}.by(-Oystercard::MIN_FARE)
      end
    end

    describe "#history" do
      it "returns an empty journey history for the oysterard if there are no trips" do
        expect(@card.history).to be_empty
      end

      let(:journey) { {entry_station: @entry_station, exit_station: @exit_station} }

      it "returns a journey history" do
        @card.touch_in(@entry_station)
        @card.touch_out(@exit_station)
        expect(@card.history).to include(journey)
      end
    end

  end
end
