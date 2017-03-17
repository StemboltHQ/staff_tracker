require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '.current_person' do
    subject { controller.current_person }

    context 'when a session is active' do
      before { session[:person_id] = person.id }
      let(:person) { FactoryGirl.create(:person) }

      it 'returns the corresponding person object' do
        expect(subject).to eq(person)
      end
    end

    context 'when there is no active session' do
      before { session[:person_id] = nil }

      it { is_expected.to be_nil }
    end
  end
end
