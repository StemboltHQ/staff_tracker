require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'GET #forbidden' do
    subject { get :forbidden }
    it { is_expected.to render_template :forbidden }
    it { is_expected.to have_http_status(403) }
  end
end
