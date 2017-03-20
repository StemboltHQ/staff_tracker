class EventsController < ApplicationController
  before_action :authenticate_person

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    authorize @event
  end

  def upcoming
    @events = Event.upcoming
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to @event
    else
      render 'new'
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :location,
      :date
    )
  end
end
