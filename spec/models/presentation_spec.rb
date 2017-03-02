# spec/models/presentation_spec.rb
require 'rails_helper'

RSpec.describe Presentation, type: :model do
  let(:person) { FactoryGirl.create(:person) }
  let(:event)  { FactoryGirl.create(:event) }

  describe 'validate model' do
    subject { FactoryGirl.create(:presentation) }

    it { is_expected.to validate_presence_of :topic }
    it { is_expected.to validate_presence_of :duration }

    it { is_expected.to belong_to :person }
    it { is_expected.to belong_to :event }

    it 'is expected to validate duration is between 0 and 15' do
      expect(subject).to validate_numericality_of(:duration)
        .is_greater_than(0).is_less_than_or_equal_to(15)
    end

    it { is_expected.to be_valid }

    describe 'person and presenter validation' do
      subject { described_class.new(presentation) }

      context 'with presenter, no person' do
        let(:presentation) do
          FactoryGirl.attributes_for(
            :presentation,
            event_id: event.id,
            presenter: 'test'
          )
        end

        it { is_expected.to be_valid }
        it 'is expected to have person: nil, presenter: "test"' do
          expect(subject).to have_attributes(
            person: nil,
            presenter: presentation[:presenter]
          )
        end
      end

      context 'with person, no presenter' do
        let(:presentation) do
          FactoryGirl.attributes_for(
            :presentation,
            event_id: event.id,
            person_id: person.id
          )
        end

        it { is_expected.to have_attributes(person: person, presenter: nil) }
        it { is_expected.to be_valid }
      end

      context 'with presenter, and person' do
        let(:presentation) do
          FactoryGirl.attributes_for(
            :presentation,
            event_id: event.id,
            presenter: 'test',
            person_id: person.id
          )
        end

        it { is_expected.to_not be_valid }
        it 'is expected to have person and presenter' do
          expect(subject).to have_attributes(
            person: person,
            presenter: presentation[:presenter]
          )
        end
      end

      context 'without presenter, or person' do
        let(:presentation) do
          FactoryGirl.attributes_for(:presentation, event_id: event.id)
        end

        it { is_expected.to_not be_valid }
      end
    end
  end

  describe 'presenter_name' do
    context 'when presenter is not present' do
      subject { FactoryGirl.create(:presentation) }

      it { is_expected.to have_attributes(presenter_name: 'John') }
    end

    context 'when presenter is present' do
      subject do
        FactoryGirl.create(:presentation, presenter: 'Testy', person: nil)
      end

      it { is_expected.to have_attributes(presenter_name: 'Testy') }
    end
  end
end
