require 'rails_helper'

RSpec.describe PersonPresentation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :person }
    it { is_expected.to belong_to :presentation }
  end
end
