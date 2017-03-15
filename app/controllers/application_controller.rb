class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_person

  def current_person
    @current_person ||= Person.find(session[:person_id]) if session[:person_id]
  end

  alias_method :current_user, :current_person
end
