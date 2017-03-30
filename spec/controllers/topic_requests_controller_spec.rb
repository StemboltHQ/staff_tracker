require 'rails_helper'

RSpec.describe TopicRequestsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to render_template :index }
    it { is_expected.to be_successful }
  end
end
