class ClearanceBatchesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  
  def index
    @clearance_batches = ClearanceBatch.all
  end

  private

  def clearance_batch_params
    params.require(:clearance_batch).permit(:id, :submitted)
  end

end
