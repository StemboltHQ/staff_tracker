require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  describe "DELETE #destroy" do
    subject { delete :destroy }
    before { session[:person_id] = 1 }

    it 'sets the session to nil' do
      expect { subject }.to change { session[:person_id] }.to(nil)
    end
  end
end
