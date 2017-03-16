require 'rails_helper'

RSpec.describe PresentationPolicy, type: :model do
  describe PresentationPolicy do
    it 'inherits from ApplicationPolicy' do
      expect(described_class).to be < ApplicationPolicy
    end
  end
end
