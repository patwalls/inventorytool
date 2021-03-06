class Api::TypeController < ApplicationController
  def index
    @types = Type.all
    render json: @types
  end

  def show
    @type = Type.find(params[:id])
    render :json => @type
  end


  def update
    @type = Type.find(params[:id])
    if @type.update_attributes(type_params)
      render :json => @type
    else
      render :json => { :errors => @type.errors.full_messages }
    end
  end

  private

  def type_params
    params.require(:type).permit(:id, :min_price)
  end
end
