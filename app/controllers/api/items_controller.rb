class Api::ItemsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    @items = Item.select("
    items.*,
    styles.name as style_name,
    styles.wholesale_price,
    styles.retail_price,
    styles.id as style_id,
    types.name as type_name
    ")
    .joins(:style,:type)
    render :json => @items
  end

  def show
    @item = Item.find(params[:id])
    if @item
      render :json => @item
    else
      render :json => { :errors => @item.errors.full_messages }
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item && @item.status == 'sellable'
      @item.clearance!
      @item.update_attributes(item_params)
      render :json => Item.query_for_callback(params[:id])
    elsif @item && @item.status == 'clearanced' && @item.clearance_batch.submitted == false
      @item.unclearance!
      @item.save!
      render :json => Item.query_for_callback(params[:id])
    else
      render :json => { :errors => @item.errors.full_messages }
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :clearance_batch_id)
  end
end
