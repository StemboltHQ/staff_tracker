class TopicRequest < ApplicationRecord
  validates :name, presence: true
end
