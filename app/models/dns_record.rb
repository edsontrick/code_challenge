class DnsRecord < ApplicationRecord
  has_many :hostnames

  accepts_nested_attributes_for :hostnames

  validates :ip, presence: true

  def as_json(options = {})
    json = {
      id: id,
      ip_address: ip
    }
    json
  end
end
