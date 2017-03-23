class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.page(params[:page]).order(:created_at)
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = Presentation.new
    authorize @presentation
  end

  def create
    @presentation = Presentation.new(presentation_params).tap do |presentation|
      presentation.person = current_person
    end
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
      :event_id
    )
  end
end
