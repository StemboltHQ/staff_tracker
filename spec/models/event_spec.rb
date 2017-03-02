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

  describe '.requiring_notification' do
    subject(:events_requiring_notification) do
      described_class.requiring_notification
    end
    context 'when there are events aligning with the NOTIFICATION_PERIOD' do
      let(:required_notif) do
        FactoryGirl.create(:event, :requiring_notification)
      end
      let(:unrequired_notif) do
        FactoryGirl.create(:event, :not_requiring_notification)
      end
      it 'returns an array of Events requiring notification' do
        expect(events_requiring_notification).to include(required_notif)
      end
      it 'doesnt include Events that arent requiring notification' do
        expect(events_requiring_notification).not_to include(unrequired_notif)
      end
    end
    context 'when there are no events aligning with the NOTIFICATION_PERIOD' do
      it 'returns an empty array' do
        expect(events_requiring_notification).to be_empty
      end
    end
  end
end
