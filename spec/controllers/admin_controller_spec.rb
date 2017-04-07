require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  controller do
    def authenticate_admin_mock
      authenticate_admin
    end
  end

  describe '#authenticate_admin' do
    subject { controller.authenticate_admin_mock }

    context 'the current person is not signed in' do
      before { mock_pundit_user_as(nil) }
      it 'raises a pundit not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is a non admin' do
      before { mock_pundit_user_as(non_admin) }
      let(:non_admin) { FactoryGirl.create(:person) }
      it 'raises a pundit not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is an admin' do
      before { mock_pundit_user_as(admin) }
      let(:admin) { FactoryGirl.create(:person, :admin) }
      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
  end
end
