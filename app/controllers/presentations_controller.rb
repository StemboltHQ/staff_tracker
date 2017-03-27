class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.joins(:event)
                                 .merge(Event.order(date: :desc))
                                 .page(params[:page])
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = Presentation.new
    authorize @presentation
  end

  def edit
    @presentation = Presentation.find(params[:id])
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

  def update
    @presentation = Presentation.find(params[:id])
    authorize @presentation

    if @presentation.update(admin_presentation_params)
      flash[:notice] = 'Presentation was successfully updated.'
      redirect_to @presentation
    else
      render 'edit'
    end
  end

  def destroy
    @presentation = Presentation.find(params[:id])
    authorize @presentation
    @presentation.destroy!

    redirect_to presentations_path
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
