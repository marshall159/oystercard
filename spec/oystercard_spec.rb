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
      end

      it "raises an error" do
        expect{ @card.top_up(1) }.to raise_error("Limit of £#{Oystercard::MAX_BALANCE} exceeded")
      end
    end
  end


  context "minimum balance required" do
    it "raises an error" do
      expect{ subject.touch_in }.to raise_error("Minimum balance £#{Oystercard::MIN_BALANCE} required")
    end
  end

  context "top_up before journey" do
    before(:example) do
      @card = Oystercard.new
      @card.top_up(3)
    end
    describe "touch_in and touch_out" do
      it "#in_journey? returns status" do
        expect(subject).not_to be_in_journey
        expect(subject.in_journey?).to be(false)
      end

      it "#touch_in changes status of #in_journey?" do
        expect { @card.touch_in }.to change { @card.in_journey? }.from(false).to(true)
      end

      it "#touch_out changes status of #in_journey?" do
        @card.touch_in
        expect { @card.touch_out }.to change { @card.in_journey? }.from(true).to(false)
      end

      it "#touch_out reduces balance by minimum fare" do
        expect { @card.touch_out }.to change { @card.balance}.by(-Oystercard::MIN_FARE)
      end
    end

  end
end
