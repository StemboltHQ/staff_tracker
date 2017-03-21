require 'rails_helper'

RSpec.describe EventSchedule do
  describe '.populate_upcoming_show_and_tell!' do
    subject { described_class.populate_upcoming_show_and_tell! }
    before { travel_to Date.new(2017, 1, 1) }
    after { travel_back }

    let(:fridays) do
      (0..3).map { |week| Date.new(2017, 1, 6 + (week * 7)) }
    end

    it 'creates show and tell events' do
      expect { subject }
        .to change { Event.where(name: 'Show & Tell').count }
        .from(0)
        .to(4)
    end

    it 'creates show and tell events that take place on Friday' do
      subject
      expect(Event.where(name: 'Show & Tell').pluck(:date)).to all(be_friday)
    end

    it 'creates an event for each Friday in the upcoming four weeks' do
      subject
      Event.where(name: 'Show & Tell').each do |event|
        expect(fridays).to include(event.date)
      end
    end

    it 'doesnt create duplicate events' do
      subject
      expect { subject }
        .not_to change { Event.where(name: 'Show & Tell').count }
    end
  end
end
