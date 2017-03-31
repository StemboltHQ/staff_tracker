require 'rails_helper'

RSpec.describe PresentationPresenter do
  subject { described_class.new(presentation, nil) }

  describe '#associable_events' do
    let(:event) { FactoryGirl.build(:event) }
    let(:past_event) { FactoryGirl.build(:event, date: 1.day.ago) }
    context 'the presentation has an associated event' do
      context 'the event is in the future' do
        let(:presentation) do
          FactoryGirl.build(:presentation, event: event)
        end
        it 'includes the event in the returned array' do
          expect(subject.associable_events).to include(event)
        end
      end
      context 'the event is in the past' do
        let(:presentation) do
          FactoryGirl.build(:presentation, event: past_event)
        end
        it 'includes the event in the returned array' do
          expect(subject.associable_events).to include(past_event)
        end
      end
    end

    context 'the presentation does not have an assoicated event' do
      let(:presentation) { FactoryGirl.build(:presentation) }
      it 'doesnt include the event in the returned array' do
        expect(subject.associable_events).not_to include(event)
      end
      it 'doesnt include past events in the returned array' do
        expect(subject.associable_events).not_to include(past_event)
      end
    end
  end
end
