require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to render_template :new }
    it { is_expected.to be_successful }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: presentation.id } }
    let!(:presentation) { FactoryGirl.create(:presentation) }

    it { is_expected.to render_template :show }
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
          person_id: person.id,
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

  describe 'GET #edit' do
    subject { get :edit, params: { id: presentation.id } }
    let!(:presentation) { FactoryGirl.create(:presentation) }

    it { is_expected.to render_template :edit }
    it { is_expected.to be_successful }
  end

  describe 'PUT #update' do
    subject { put :update, params: params }
    let(:presentation) { FactoryGirl.create(:presentation) }
    let(:new_topic) { 'Goofing around!' }
    let(:params) do
      { id: presentation.id, presentation: { topic: new_topic } }
    end

    context 'valid params' do
      it { is_expected.to redirect_to presentation }

      it 'is expected to be successful' do
        expect(response).to be_successful
      end

      it 'is expected to update the presentations attributes' do
        expect { subject }.to change { presentation.reload.topic }
          .to(new_topic)
      end
    end

    context 'invalid params' do
      let(:params) do
        { id: presentation.id, presentation: { topic: nil } }
      end
      it { is_expected.to redirect_to edit_presentation_path(presentation) }

      it 'is expected to be successful' do
        expect(response).to be_successful
      end

      it 'is expected to not update the presentations attributes' do
        expect { subject }.not_to change { presentation.reload.topic }
      end
    end
  end
end
