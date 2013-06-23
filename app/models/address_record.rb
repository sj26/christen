require "resolv"

class AddressRecord < Record
  validates :content, presence: true, format: {with: Resolv::IPv4::Regex}
end
