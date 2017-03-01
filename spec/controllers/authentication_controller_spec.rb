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
    it 'redirects the person to the root url' do
      expect(subject).to redirect_to(root_url)
    end
    it 'creates a new session' do
      expect { subject }.to change { session[:person_id] }.from nil
    end
  end
end
