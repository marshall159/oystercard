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

  describe "#deduct" do

    before(:context) do
      @card = Oystercard.new
      @card.top_up(10)
    end

    it "reduces balance by amount" do
      expect { @card.deduct(5) }.to change { @card.balance }.from(10).to(5)
    end
  end

end
