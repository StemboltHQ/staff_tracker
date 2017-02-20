# spec/controllers/presentations_controller_spec.rb
require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it 'renders the template' do
      expect(subject).to render_template :index
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: params } }

    let(:params) { FactoryGirl.create(:presentation) }

    it 'renders the template' do
      expect(subject).to render_template :show
    end
  end

  describe 'GET #new' do
    subject { get :new }

    it 'renders the template' do
      expect(subject).to render_template :new
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: params } }

    let(:params) { FactoryGirl.create(:presentation) }

    it 'renders the template' do
      expect(subject).to render_template :edit
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { presentation: params } }

    let(:params) { FactoryGirl.attributes_for(:presentation) }

    context 'with valid attributes' do
      it 'changes presentation count by +1' do
        expect { subject }.to change(Presentation, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      let(:params) { { subject: nil } }

      it 'does not save the new presentation' do
        expect { subject }.to_not change(Presentation, :count)
      end
      it 're-runs presentation#new' do
        expect(subject).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    subject do
      put :update, params: { id: presentation.id, presentation: params }
    end

    let(:presentation) { FactoryGirl.create(:presentation) }

    context 'valid attributes' do
      let(:params) { { subject: 'Testing' } }

      it 'should update presentation' do
        expect { subject }
          .to change { presentation.reload.subject }
          .from('Test Presentation')
          .to('Testing')
      end
      it 'renders the template' do
        expect(subject).to redirect_to presentation
      end
    end

    context 'invalid attributes' do
      let(:params) { { subject: nil } }

      it "shouldn't update presentation" do
        expect { subject }
          .to_not change { presentation.reload.subject }
          .from('Test Presentation')
      end
      it 'renders the template' do
        expect(subject).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: presentation.id } }

    let!(:presentation) { FactoryGirl.create(:presentation) }

    it 'changes presentation count by -1' do
      expect { subject }.to change(Presentation, :count).by(-1)
    end
    it 'renders the presentations#index template' do
      expect(subject).to redirect_to presentations_url
    end
  end
end
