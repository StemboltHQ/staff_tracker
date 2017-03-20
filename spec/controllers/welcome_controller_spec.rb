require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to be_successful }
    it { is_expected.to render_template(:index) }
  end

  describe 'GET #sign_in' do
    subject { get :sign_in }

    it { is_expected.to be_successful }
    it { is_expected.to render_template(:sign_in) }
  end
end
