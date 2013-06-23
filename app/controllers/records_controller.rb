class RecordsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_domain_and_records
  before_filter :prepare_record, only: [:edit, :update, :destroy]

  respond_to :html

  def new
    @record = @records.build.becomes(Record[params.require(:record_type)])
    respond_with @domain, @record
  end

  def create
    @record = Record[params.require(:record_type)].create(record_params.merge(domain: @domain))
    respond_with @domain, @record, location: edit_domain_path(@domain)
  end

  def edit
    respond_with @domain, @record
  end

  def update
    @record.update_attributes(record_params)
    respond_with @domain, @record, location: edit_domain_path(@domain)
  end

  def destroy
    @record.destroy
    respond_with @domain, @record, location: edit_domain_path(@domain)
  end

private

  def prepare_domain_and_records
    @domain = current_user.domains.find_by_name!(params[:domain_id])
    @records = @domain.records
  end

  def prepare_record
    @record = @records.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:name, :ttl, :priority, :content)
  end
end
