module Christen
  def self.ca_key_path
    Rails.root.join("db", "certs", "ca.key")
  end

  def self.ca_key
    @ca_key ||= if File.exist? ca_key_path
      OpenSSL::PKey.read(File.read(ca_key_path))
    else
      OpenSSL::PKey::RSA.generate(2048).tap do |key|
        File.write ca_key_path, key
      end
    end
  end

  def self.ca_name
    @ca_name ||= OpenSSL::X509::Name.parse 'CN=CA Root/OU=Railscamp 13/O=Ruby Australia/L=Somers/ST=Victoria/C=Australia'
  end

  def self.ca_cert_path
    Rails.root.join("db", "certs", "ca.crt")
  end

  def self.ca_cert
    @ca_cert ||= if File.exist? ca_cert_path
      OpenSSL::X509::Certificate.new(File.read(ca_cert_path))
    else
      OpenSSL::X509::Certificate.new.tap do |cert|
        cert.serial = 0
        cert.version = 2
        cert.not_before = Time.now
        cert.not_after = 2.days.from_now

        cert.public_key = ca_key.public_key
        cert.subject = ca_name
        cert.issuer = ca_name

        extension_factory = OpenSSL::X509::ExtensionFactory.new
        extension_factory.subject_certificate = cert
        extension_factory.issuer_certificate = cert

        cert.add_extension extension_factory.create_extension('subjectKeyIdentifier', 'hash')
        cert.add_extension extension_factory.create_extension('basicConstraints', 'CA:TRUE', true)
        cert.add_extension extension_factory.create_extension('keyUsage', 'cRLSign,keyCertSign', true)

        cert.sign ca_key, OpenSSL::Digest::SHA1.new

        File.write ca_cert_path, cert.to_pem
      end
    end
  end
end
