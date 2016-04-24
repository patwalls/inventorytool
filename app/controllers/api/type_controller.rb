class Api::TypeController < ApplicationController
  def index
    @types = Type.all
    render json: @types
  end
end
