require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'POST #create' do
    subject { post :create, params: { event: params } }

    context 'with valid attributes' do
      let(:params) { FactoryGirl.attributes_for(:event) }

      it 'redirects' do
        expect(subject.status).to eq(302)
      end
      it 'renders the event' do
        expect(subject).to redirect_to(Event.last)
      end
      it 'changes the event count +1' do
        expect { subject }.to change(Event, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:params) { FactoryGirl.attributes_for(:event, name: nil) }

      it 'responds 200' do
        expect(subject.status).to eq(200)
      end
      it 'does not change event count' do
        expect { subject }.to_not change(Event, :count)
      end
      it 'redirects to :new' do
        expect(subject).to render_template(:new)
      end
    end
  end
end
