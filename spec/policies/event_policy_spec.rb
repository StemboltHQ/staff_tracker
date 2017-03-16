require 'rails_helper'

RSpec.describe EventPolicy, type: :model do
  describe EventPolicy do
    it 'inherits from ApplicationPolicy' do
      expect(described_class).to be < ApplicationPolicy
    end
  end
end
