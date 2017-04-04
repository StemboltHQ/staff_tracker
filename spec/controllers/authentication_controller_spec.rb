require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  describe '#google' do
    subject do
      post :google
      response
    end

    it 'creates a new person' do
      expect { subject }.to change { Person.count }.by(1)
    end

    it 'creates a new session' do
      expect { subject }.to change { session[:person_id] }.from nil
    end

    context 'omniauth origin is nil' do
      before do
        request.env['omniauth.origin'] = nil
      end

      it 'redirects the person to the root url' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'omniauth origin is not nil' do
      before do
        request.env['omniauth.origin'] = 'http://test.host/presentations'
      end

      it 'redirects the person to the path location saved prior to login' do
        expect(subject).to redirect_to(presentations_path)
      end
    end
  end
end
