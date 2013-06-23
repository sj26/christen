class Certificate < ActiveRecord::Base
  belongs_to :domain, counter_cache: true
  has_one :user, through: :domain

  before_validation { name.downcase! }

  validates :domain, presence: true

  def key
    @key ||= OpenSSL::PKey.read(key_pem) if key_pem?
  end

  def request
    @request ||= OpenSSL::X509::Request.new(request_pem) if request_pem?
  end

  def certificate
    @request ||= OpenSSL::X509::Certificate.new(certificate_pem) if certificate_pem
  end
end
