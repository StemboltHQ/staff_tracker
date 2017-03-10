require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'validate model' do
    it { is_expected.to have_many(:people) }
  end
end
