class Api::ItemsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    @items = Item.all
    render :json => @items
  end

  def show
    @item = Item.find(params[:id])
    render :json => @item
  end

  def update
    @item = Item.find(params[:id])
    @item.clearance!
    @item.update_attributes(item_params)
    @item.save!
    flash[:alert] = "Hello I am working!!!"
    render nothing: true, status: 204
  end

  private

  def item_params
    params.require(:item).permit(:id, :clearance_batch_id)
  end
end
