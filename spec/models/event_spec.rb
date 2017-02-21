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

  describe '.notification_necessary?' do
    context 'when the date of the event is within the notif period' do
      let(:required_notif) do
        FactoryGirl.create(:event, date: Date.today)
      end
      it 'returns true' do
        expect(required_notif.notification_necessary?).to eq(true)
      end
    end

    context 'when the date of the event is outside the notif period' do
      let(:unrequired_notif) do
        FactoryGirl.create(
          :event, date: Date.today + Event::NOTIFICATION_PERIOD
        )
      end
      it 'returns false' do
        expect(unrequired_notif.notification_necessary?).to eq(false)
      end
    end
  end
end
