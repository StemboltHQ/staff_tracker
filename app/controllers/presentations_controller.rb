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
    if current_person && current_person.admin?
      @presentation = Presentation.new(admin_presentation_params)
    else
      create_params = presentation_params.merge(person: current_person)
      @presentation = Presentation.new(create_params)
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

  def admin_presentation_params
    params.require(:presentation).permit(
      :presenter,
      :topic,
      :duration,
      :description,
      :event_id,
      :person_id
    )
  end

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
