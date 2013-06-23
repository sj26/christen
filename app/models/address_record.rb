class AddressRecord < Record
  validates :name, uniqueness: {scope: [:domain_id, :name]}
  validates :content, presence: true
end
