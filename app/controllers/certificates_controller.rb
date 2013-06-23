class CertificatesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_domain_and_certificates
  before_filter :prepare_certificate, only: [:edit, :update, :destroy]

  respond_to :html

  def new
    @certificate = @certificates.build
    respond_with @domain, @certificate
  end

  def create
    @certificate = @certificates.create(certificate_params)
    respond_with @domain, @certificate, location: @domain
  end

  def edit
    respond_with @domain, @certificate
  end

  def update
    @certificate.update_attributes(certificate_params)
    respond_with @domain, @certificate, location: @domain
  end

  def destroy
    @certificate.destroy
    respond_with @domain, @certificate, location: @domain
  end

private

  def prepare_domain_and_certificates
    @domain = current_user.domains.find_by_name!(params[:domain_id])
    @certificates = @domain.certificates
  end

  def prepare_certificate
    @certificate = @certificates.find(params[:id])
  end

  def certificate_params
    params.require(:certificate).permit(:name, :request_csr)
  end
end
