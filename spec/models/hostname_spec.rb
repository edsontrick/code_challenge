require 'rails_helper'

RSpec.describe Hostname, type: :model do
  let(:dns_record) { DnsRecord.new(ip: '1.1.1.1')}

  it "is valid with valid attributes" do
    expect(Hostname.new(hostname: 'lorem.com', dns_record: dns_record)).to be_valid
  end

  it "is valid without dns_record attribute" do
    expect(Hostname.new(hostname: 'lorem.com')).to be_invalid
  end

  it "is invalid without hostname attribute" do
    expect(Hostname.new).to be_invalid
  end
end
