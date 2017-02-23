require 'rails_helper'

RSpec.describe PresentationsController, type: :controller do
  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to render_template :new }
    it { is_expected.to be_successful }
  end

  describe 'GET #show' do
    subject { get :show, params: { id: 1 } }
    let!(:presentation) { FactoryGirl.create(:presentation) }

    it { is_expected.to render_template :show }
    it { is_expected.to be_successful }
  end
end
