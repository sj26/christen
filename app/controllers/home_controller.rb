class HomeController < ApplicationController
  def show
  end

  def cert
    respond_to do |format|
      format.html
      format.pem { send_data Christen.ca_cert.to_pem }
    end
  end
end
