# app/controllers/events_controller.rb
class EventsController < ApplicationController
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

  def edit
    @event = Event.find(params[:id])
    authorize @event
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

  def update
    @event = Event.find(params[:id])
    authorize @event

    if @event.update(event_params)
      flash[:notice] = 'Event was successfully updated.'
      redirect_to @event
    else
      render 'edit'
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
