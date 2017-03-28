# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Event associations' do
    subject { described_class.reflect_on_association(:presentations) }
    it 'has many presentations' do
      expect(subject.macro).to eq :has_many
    end
    it 'destroys dependents' do
      expect(subject.options[:dependent]) .to eq(:destroy)
    end
  end

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

  describe '.duration' do
    subject(:event_duration) { event.duration }
    context 'when there are no presentations assigned' do
      let(:event) { FactoryGirl.build(:event) }
      it 'returns zero' do
        expect(event_duration).to eq(0)
      end
    end
    context 'when there is one presentation assigned' do
      let(:event) { FactoryGirl.build(:event, presentations: [presentation]) }
      let(:presentation) do
        FactoryGirl.build(:presentation)
      end
      it 'returns the assigned presentations duration' do
        expect(event_duration).to eq(presentation.duration)
      end
    end
    context 'when there are multiple presentations assigned' do
      let(:number) { 3 }
      let(:event) { FactoryGirl.build(:event, presentations: presentations) }
      let!(:presentations) do
        build_list(:presentation, number)
      end
      it 'returns the assigned presentations duration' do
        expect(event_duration).to eq(presentations.first.duration * number)
      end
    end
  end

  describe '#upcoming?' do
    subject { event.upcoming? }
    context 'the event is in the future' do
      let!(:event) do
        FactoryGirl.create(:event, date: 1.hour.from_now)
      end

      it { is_expected.to eq(true) }
    end

    context 'the event is in the past' do
      let!(:event) do
        FactoryGirl.create(:event, date: -1.hours.from_now)
      end

      it { is_expected.to eq(false) }
    end
  end
end
