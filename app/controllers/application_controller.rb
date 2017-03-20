class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_person
  helper_method :authenticate_person

  private

  def current_person
    @current_person ||= Person.find(session[:person_id]) if session[:person_id]
  end

  def authenticate_person
    unless current_person
      redirect_to sign_in_path
      return false
    end
  end

  alias_method :current_user, :current_person
end
