class DomainsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_domains
  before_filter :prepare_domain, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    respond_with @domains
  end

  def new
    respond_with @domain = @domains.build
  end

  def create
    respond_with @domain = @domains.create(params.require(:domain).permit(:name)), location: [:edit, @domain]
  end

  def show
    respond_with @domain
  end

  def destroy
    @domain.destroy
    respond_with @domain
  end

private

  def prepare_domains
    @domains = current_user.domains
  end

  def prepare_domain
    @domain = current_user.domains.find(params[:id])
  end
end
