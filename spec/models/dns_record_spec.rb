require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  it "is valid with valid attributes" do
    expect(DnsRecord.new(ip: '1.1.1.1')).to be_valid
  end

  it "is invalid without ip attribute" do
    expect(DnsRecord.new).to be_invalid
  end
end
