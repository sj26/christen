class Domain < ActiveRecord::Base
  belongs_to :user
  has_many :records, dependent: :destroy

  before_validation { name.downcase! }

  validates :user, presence: true
  validates :name, uniqueness: true
  validate { errors.add :name, "must have a valid TLD" unless PublicSuffix.valid? name }

  def public_suffix
    PublicSuffix.parse name
  end

  delegate :tld, :sld, :trd, to: :public_suffix

  def serial
    created_at.strftime("%Y%m%d%H%M%S%L").to_d
  end

  def ttl
    0
  end

  def refresh
    1.hour
  end

  def retry_refresh
    1.hour
  end

  def expire
    1.hour
  end

  def minimum
    1.minute
  end

  def to_s
    name
  end

  def to_param
    name
  end
end
