class PresentationsController < ApplicationController
  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = Presentation.new
  end
end
