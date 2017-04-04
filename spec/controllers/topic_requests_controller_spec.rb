require 'rails_helper'

RSpec.describe TopicRequestsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to render_template :index }
    it { is_expected.to be_successful }
  end

  describe 'POST #create' do
    subject { post :create, params: { topic_request: params } }

    context 'with valid attributes' do
      let(:params) { FactoryGirl.attributes_for(:topic_request) }

      it 'redirect to presentations/requests' do
        expect(subject).to redirect_to(requests_presentations_path)
      end
      it 'changes the topic request count +1' do
        expect { subject }.to change(TopicRequest, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:params) { FactoryGirl.attributes_for(:topic_request, name: nil) }

      it { is_expected.to be_successful }
      it { is_expected.to render_template :index }
      it 'does not change the topic request count' do
        expect { subject }.to_not change(TopicRequest, :count)
      end
    end
  end
end
