class PresentationsController < ApplicationController
  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(presentation_params)

    if @presentation.save
      flash[:notice] = 'Presentation was successfully created'
      redirect_to @presentation
    else
      render 'new'
    end
  end

  def edit
    @presentation = Presentation.find(params[:id])
  end

  def update
    @presentation = Presentation.find(params[:id])

    if @presentation.update(presentation_params)
      flash[:notice] = 'Presentation was successfully updated'
      redirect_to @presentation
    else
      redirect_to edit_presentation_path(@presentation)
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
