class AdminController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    raise Pundit::NotAuthorizedError unless current_person
    authorize current_person, :admin?
  end
end
