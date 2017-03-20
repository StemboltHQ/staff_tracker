class PresentationsController < ApplicationController
  before_action :authenticate_person

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = Presentation.new
    authorize @presentation
  end

  def create
    @presentation = Presentation.new(presentation_params)
    authorize @presentation

    if @presentation.save
      flash[:notice] = 'Presentation was successfully created'
      redirect_to @presentation
    else
      render 'new'
    end
  end

  private

  def presentation_params
    params.require(:presentation).permit(
      :presenter,
      :topic,
      :duration,
      :description,
      :person_id,
      :event_id
    )
  end
end
