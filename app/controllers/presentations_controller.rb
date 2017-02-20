# app/controllers/presentations_controller.rb
class PresentationsController < ApplicationController
  def index
    @presentations = Presentation.all
  end

  def show
    @presentation = Presentation.find(params[:id])
  end

  def new
    @presentation = Presentation.new
  end

  def edit
    @presentation = Presentation.find(params[:id])
  end

  def create
    @presentation = Presentation.new(presentation_params)

    if @presentation.save
      flash[:notice] = 'Presentation was successfully created.'
      redirect_to @presentation
    else
      render 'new'
    end
  end

  def update
    @presentation = Presentation.find(params[:id])

    if @presentation.update(presentation_params)
      flash[:notice] = 'Presentation was successfully updated.'
      redirect_to @presentation
    else
      render 'edit'
    end
  end

  def destroy
    @presentation = Presentation.find(params[:id])
    @presentation.destroy

    redirect_to presentations_path
  end

  private

  def presentation_params
    params.require(:presentation)
          .permit(:subject,
                  :content,
                  :date,
                  person_ids: [])
  end
end
