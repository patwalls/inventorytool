class Api::StyleController < ApplicationController
  def index
    @types = Style.getTypes
    render json: @types
  end
end

## TODO i dont think i need this...
