require 'rails_helper'

RSpec.describe Admin::PeopleController, type: :controller do
  describe 'GET index' do
    subject { get :index }
    before { mock_pundit_user_as(admin) }
    let(:admin) { FactoryGirl.build(:person, :admin) }

    it { is_expected.to render_template :index }
    it { is_expected.to be_successful }
  end
end
