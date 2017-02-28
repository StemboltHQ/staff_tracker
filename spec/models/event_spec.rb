# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { described_class.new(event) }

  describe 'valid model' do
    let(:event) { FactoryGirl.attributes_for(:event) }
    it { is_expected.to be_valid }
  end

  describe 'name' do
    context 'when valid' do
      let(:event) { FactoryGirl.attributes_for(:event) }
      it { is_expected.to be_valid }
    end
    context 'when nil' do
      let(:event) { FactoryGirl.attributes_for(:event, name: nil) }
      it { is_expected.to_not be_valid }
    end
  end

  describe 'date' do
    context 'when valid' do
      let(:event) { FactoryGirl.attributes_for(:event) }
      it { is_expected.to be_valid }
    end
    context 'when nil' do
      let(:event) { FactoryGirl.attributes_for(:event, date: nil) }
      it { is_expected.to_not be_valid }
    end
  end

  describe 'location' do
    context 'when valid' do
      let(:event) { FactoryGirl.attributes_for(:event) }
      it { is_expected.to be_valid }
    end
    context 'when nil' do
      let(:event) { FactoryGirl.attributes_for(:event, location: nil) }
      it { is_expected.to_not be_valid }
    end
  end

  describe 'scope: upcoming' do
    subject { described_class.upcoming }

    let!(:event_past) { FactoryGirl.create(:event, date: Time.zone.yesterday) }
    let!(:event_present) { FactoryGirl.create(:event, date: Time.zone.today) }
    let!(:event_future) { FactoryGirl.create(:event, date: Time.zone.tomorrow) }

    context 'future events' do
      it { is_expected.to include(event_present, event_future) }
    end

    context 'past events' do
      it { is_expected.to_not include(event_past) }
    end
  end
end
