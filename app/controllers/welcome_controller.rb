class WelcomeController < ApplicationController
  before_action :authenticate_person, except: [:sign_in]

  def index
    @next_event = Event.upcoming.order(:date).first
  end

  def sign_in; end
end
