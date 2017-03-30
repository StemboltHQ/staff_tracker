class TopicRequestsController < ApplicationController
  def index
    @topic_requests = TopicRequest.all
  end
end
