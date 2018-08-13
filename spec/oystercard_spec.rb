require "oystercard"

describe Oystercard do
#  let(:subject) { Oystercard.new }
  # it "it responds to #balance" do
  #   expect(subject).to respond_to(:balance)
  # end

  it "has initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "responds to #top_up" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "adds amount to #balance" do
    card = Oystercard.new
    amount = 20
    card.top_up(amount)
    expect(card.balance).to eq(amount)
  end


end
