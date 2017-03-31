require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  describe '#authenticate_admin' do
    subject { controller.send(:authenticate_admin) }

    context 'the current person is not signed in' do
      before { mock_pundit_user_as(nil) }
      it 'raises a pundit not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is a non admin' do
      before { mock_pundit_user_as(non_admin) }
      let(:non_admin) { FactoryGirl.build(:person) }
      it 'raises a pundit not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is an admin' do
      before { mock_pundit_user_as(admin) }
      let(:admin) { FactoryGirl.build(:person, :admin) }
      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
  end
end
