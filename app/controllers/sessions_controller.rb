class SessionsController < ApplicationController
  def destroy
    session[:person_id] = nil
    redirect_to root_path
  end
end
