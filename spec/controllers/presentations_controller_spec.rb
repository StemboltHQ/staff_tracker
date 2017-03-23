require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  context 'the current person is an admin' do
    let(:admin_person) { FactoryGirl.build(:person, :admin) }

    before { mock_pundit_user_as(admin_person) }

    describe 'GET #new' do
      subject { get :new }

      it { is_expected.to render_template :new }
      it { is_expected.to be_successful }
    end

    describe 'POST #create' do
      subject { post :create, params: { presentation: params } }
      let!(:person) { FactoryGirl.create(:person) }
      let!(:event) { FactoryGirl.create(:event) }

      context 'valid params' do
        let(:params) do
          FactoryGirl.attributes_for(
            :presentation,
            event_id: event.id
          )
        end

        it { is_expected.to redirect_to Presentation.last }

        it 'is expected to be successful' do
          expect(response).to be_success
        end

        it 'is expected to change presentation count +1' do
          expect { subject }.to change(Presentation, :count).by(1)
        end
      end

      context 'invalid params' do
        let(:params) { FactoryGirl.attributes_for(:presentation) }

        it { is_expected.to render_template :new }
        it { is_expected.to be_successful }

        it 'is expected to not change presentation count' do
          expect { subject }.to_not change(Presentation, :count)
        end
      end
    end
  end
  context 'the current person is a non-admin' do
    let(:non_admin) { FactoryGirl.build(:person) }

    before { mock_pundit_user_as(non_admin) }

    describe 'GET #show' do
      subject { get :show, params: { id: presentation.id } }
      let!(:presentation) { FactoryGirl.create(:presentation) }

      it { is_expected.to render_template :show }
      it { is_expected.to be_successful }
    end
  end

  context 'the current person is not signed in' do
    let(:nil_person) { nil }

    before { mock_pundit_user_as(nil_person) }

    describe 'POST #create' do
      subject { post :create, params: { presentation: params } }
      let(:event) { FactoryGirl.create(:event) }
      let(:params) do
        FactoryGirl.attributes_for(
          :presentation,
          event_id: event.id
        )

        it 'throws a not authorized error' do
          expect { subject }.to raise_error(Pundit::NotAuthorizedError)
        end
      end
    end

    describe 'GET #index' do
      subject { get :index }

      it { is_expected.to render_template :index }
      it { is_expected.to be_successful }
    end
  end
end
