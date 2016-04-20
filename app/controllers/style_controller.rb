class StyleController < ApplicationController
  def index
    @styles = Style.all
    render json: @styles
  end
end
