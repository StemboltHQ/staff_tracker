require 'rails_helper'

RSpec.describe Admin::PeopleController, type: :controller do
  describe 'inheritance' do
    it 'inherits from the admin controller' do
      expect(described_class).to be < AdminController
    end
  end

  describe 'GET index' do
    subject { get :index }
    before { mock_pundit_user_as(admin) }
    let(:admin) { FactoryGirl.create(:person, :admin) }

    it { is_expected.to render_template :index }
    it { is_expected.to be_successful }
  end
end
