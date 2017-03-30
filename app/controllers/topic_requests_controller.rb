class TopicRequestsController < ApplicationController
  def index
    @topic_requests = TopicRequest.all
    @topic_request = TopicRequest.new
  end

  def create
    @topic_request = TopicRequest.new(topic_request_params)

    if @topic_request.save
      flash[:success] = 'Topic request was successfully created.'
      redirect_to requests_presentations_path
    else
      @topic_requests = TopicRequest.all
      render 'index'
    end
  end

  private

  def topic_request_params
    params.require(:topic_request).permit(
      :name
    )
  end
end
