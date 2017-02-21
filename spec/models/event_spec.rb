# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { described_class.new(event) }

  describe 'valid model' do
    let(:event) { FactoryGirl.attributes_for(:event) }
    it { is_expected.to be_valid }
  end

  describe 'name' do
    context 'when nil' do
      let(:event) { FactoryGirl.attributes_for(:event, name: nil) }
      it { is_expected.to_not be_valid }
    end
  end

  describe 'date' do
    context 'when nil' do
      let(:event) { FactoryGirl.attributes_for(:event, date: nil) }
      it { is_expected.to_not be_valid }
    end
  end

  describe 'location' do
    context 'when nil' do
      let(:event) { FactoryGirl.attributes_for(:event, location: nil) }
      it { is_expected.to_not be_valid }
    end
  end
end
