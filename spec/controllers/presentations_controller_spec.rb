require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to render_template :new }
    it { is_expected.to be_successful }
  end
end
