require 'station'

describe Station do
  subject { described_class.new("Victoria", 1) }

  it "returns #name" do
    expect(subject.name).to eq("Victoria")
  end

  it "returns #zone" do
    expect(subject.zone).to eq(1)
  end
end
