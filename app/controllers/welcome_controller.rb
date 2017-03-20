class WelcomeController < ApplicationController
  def index
    @next_event = Event.upcoming.order(:date).first
  end
end
