require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller(described_class) do
      before_action :authenticate_person
    def index
      current_user

      render nothing: true
    end
  end

  describe '.current_person' do
    subject { get :index  }

    context 'when a session is active' do
      let(:person) { FactoryGirl.create(:person) }
      before { session[:person_id] = person.id }

      it 'memoizes the current person' do
        subject
        expect(assigns[:current_person]).to eq(person)
      end
    end

    context 'when there is no active session' do
      before { session[:person_id] = nil }

      it 'the current person in nil' do
        expect(assigns[:current_person]).to be_nil
      end
    end
  end

  describe '.authenticate_person' do
    subject { get :index }

    context 'when the person is signed in' do
      before { sign_in_as(person) }
      let(:person) { FactoryGirl.build(:person) }

      it { is_expected.to_not redirect_to(sign_in_path) }
    end

    context 'when the person isnt signed in' do
      before { session[:person_id] = nil }

      it { is_expected.to redirect_to(sign_in_path) }
    end
  end
end
