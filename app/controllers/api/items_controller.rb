class Api::ItemsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    @items = Item.select("items.*,styles.*,types.name as type_name").joins(:style).joins(:type)
    render :json => @items
  end

  def show
    @item = Item.find(params[:id])
    render :json => @item
  end

  def update
    @item = Item.find(params[:id])
    if @item && @item.status == 'sellable'
      @item.clearance!
      @item.update_attributes(item_params)
      @item.save!
      flash[:alert] = "Item #{@item.id} has been clearanced."
    elsif @item && @item.status == 'clearanced'
      @item.unclearance!
      @item.save!
      flash[:alert] = "Item #{@item.id} has been unclearanced."
    else
      flash[:alert] = "Item #{@item.id} could not be clearanced"
      p flash[:alert]
    end
    render nothing: true, status: 204
  end

  private

  def item_params
    params.require(:item).permit(:id, :clearance_batch_id)
  end
end
