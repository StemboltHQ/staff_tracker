class WelcomeController < ApplicationController
  def index
    @next_event = Event.upcoming.order(:date).first
  end

  def sign_in; end
end
