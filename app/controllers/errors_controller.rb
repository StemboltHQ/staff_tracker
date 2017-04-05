class ErrorsController < ApplicationController
  def forbidden
    render status: 403
  end
end
