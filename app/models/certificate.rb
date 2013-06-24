class Certificate < ActiveRecord::Base
  belongs_to :domain, counter_cache: true
  has_one :user, through: :domain

  before_validation do
    self.name = PublicSuffix.parse(common_name).subdomain.to_s if common_name
  end

  validates :domain, presence: true
  validate do
    if not request.present?
      errors[:request_pem] << "is not a valid certificate request"
    elsif not common_name.present?
      errors[:request_pem] << "does not contain a common name"
    elsif PublicSuffix.parse(common_name).domain != domain.name
      errors[:request_pem] << "is not within the #{domain.name} domain"
    end
  end

  before_create :sign!

  def key
    @key ||= OpenSSL::PKey.read(key_pem) if key_pem?
  end

  def request
    @request ||= OpenSSL::X509::Request.new(request_pem) rescue nil if request_pem?
  end

  def common_name
    if request
      request.subject.to_a.find { |(name, data, type)| name == "CN" }.try(:second)
    end
  end

  def humanized_name
    [name.presence, domain.name].compact.join(".")
  end

  def certificate
    @certificate ||= OpenSSL::X509::Certificate.new(certificate_pem) if certificate_pem
  end

  def sign!
    @certificate = OpenSSL::X509::Certificate.new.tap do |cert|
      cert.serial = 0
      cert.version = 2
      cert.not_before = Time.now
      cert.not_after = 2.days.from_now

      cert.public_key = request.public_key
      cert.subject = request.subject
      cert.issuer = Christen.ca_cert.subject

      cert.sign Christen.ca_key, OpenSSL::Digest::SHA1.new

      write_attribute :certificate_pem, cert.to_pem
    end
  end
end
