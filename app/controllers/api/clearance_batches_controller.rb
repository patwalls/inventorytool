class Api::ClearanceBatchesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    @clearance_batches = ClearanceBatch.all
    p 'batch index is being called'
    render :json => @clearance_batches
  end

  def create
    if !params[:csv_batch_file]
      @batch = ClearanceBatch.new
      @batch.save
      render :json => @batch
    else
      clearancing_status = ClearancingService.new.process_file(params[:csv_batch_file].tempfile)
      clearance_batch    = clearancing_status.clearance_batch
      alert_messages     = []
      if clearance_batch.persisted?
        flash[:notice]  = "#{clearance_batch.items.count} items clearanced in batch #{clearance_batch.id}"
      else
        alert_messages << "No new clearance batch was added"
      end
      if clearancing_status.errors.any?
        alert_messages << "#{clearancing_status.errors.count} item ids raised errors and were not clearanced"
        clearancing_status.errors.each {|error| alert_messages << error }
      end
      flash[:alert] = alert_messages.join("<br/>") if alert_messages.any?
      redirect_to action: :index
    end
  end

end
