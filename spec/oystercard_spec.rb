require "oystercard"

describe Oystercard do
#  let(:subject) { Oystercard.new }
  it "it responds to #balance" do
    expect(subject).to respond_to(:balance)
  end

  it "has initial balance of 0" do
    expect(subject.balance).to eq(0)
  end
end
