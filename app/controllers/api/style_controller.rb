class Api::StyleController < ApplicationController
  def index
    @styles = Style.all
    render json: @styles
  end
end

## TODO i dont think i need this...
