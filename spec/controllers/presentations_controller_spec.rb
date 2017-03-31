require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  let(:nil_person) { nil }
  let(:non_admin) { FactoryGirl.build(:person) }
  let(:admin_person) { FactoryGirl.build(:person, :admin) }

  describe 'GET #index' do
    subject { get :index }

    context 'the current person is not signed in' do
      before { mock_pundit_user_as(nil_person) }

      it { is_expected.to render_template :index }
      it { is_expected.to be_successful }
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: presentation.id } }
    let!(:presentation) { FactoryGirl.create(:presentation) }

    context 'the current person is not signed in' do
      before { mock_pundit_user_as(nil_person) }

      it { is_expected.to render_template :show }
      it { is_expected.to be_successful }
    end
  end

  describe 'GET #new' do
    subject { get :new }

    context 'the current person is not signed in' do
      before { mock_pundit_user_as(nil_person) }

      it 'throws a not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is a non-admin' do
      before { mock_pundit_user_as(non_admin) }

      it { is_expected.to render_template :new }
      it { is_expected.to be_successful }
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: presentation.id, event_id: event.id } }
    let(:presentation) { FactoryGirl.create(:presentation) }
    let(:event) { FactoryGirl.create(:event, presentations: [presentation]) }

    context 'the current person is a non-admin' do
      before { mock_pundit_user_as(non_admin) }

      it 'throws a not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is an admin' do
      before { mock_pundit_user_as(admin_person) }

      it { is_expected.to render_template :edit }
      it { is_expected.to be_successful }
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { presentation: params } }
    let(:event) { FactoryGirl.create(:event) }
    let(:person) { FactoryGirl.create(:person) }

    context 'the current person is not signed in' do
      before { mock_pundit_user_as(nil_person) }

      let(:params) do
        FactoryGirl.attributes_for(
          :presentation,
          event_id: event.id
        )
      end

      it 'throws a not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is a non-admin' do
      before { mock_pundit_user_as(non_admin) }

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

    context 'the current person is an admin' do
      before { mock_pundit_user_as(admin_person) }

      context 'valid params' do
        let(:params) do
          FactoryGirl.attributes_for(
            :presentation,
            event_id: event.id,
            person_id: person.id
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

  describe 'PATCH #update' do
    subject do
      patch :update, params: { id: presentation.id, presentation: attr }
    end
    let(:presentation) { FactoryGirl.create(:presentation) }

    context 'the current person is a non-admin' do
      before { mock_pundit_user_as(non_admin) }
      let(:attr) { { topic: 'New Topic' } }

      it 'throws a not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is an admin' do
      before { mock_pundit_user_as(admin_person) }

      context 'changing topic' do
        let(:attr) { { topic: 'New Topic' } }

        it { is_expected.to redirect_to presentation }

        it 'should update presentation' do
          expect { subject }
            .to change { presentation.reload.topic }
            .from('Being Awesome')
            .to('New Topic')
        end
      end

      context 'invalid attributes' do
        let(:attr) { { topic: nil } }

        it { is_expected.to render_template :edit }

        it 'should not update presentation' do
          expect { subject }
            .to_not change { presentation.reload.topic }
            .from('Being Awesome')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: presentation.id } }
    let!(:presentation) { FactoryGirl.create(:presentation) }

    context 'the current person is a non-admin' do
      before { mock_pundit_user_as(non_admin) }

      it 'throws a not authorized error' do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'the current person is an admin' do
      before { mock_pundit_user_as(admin_person) }

      it { is_expected.to redirect_to presentations_path }

      it 'changes presentation count by -1' do
        expect { subject }.to change(Presentation, :count).by(-1)
      end
    end
  end
end
