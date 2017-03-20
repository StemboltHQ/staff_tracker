# spec/controllers/people_controller_spec.rb
require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  before { sign_in_as(person) }
  let(:person) { FactoryGirl.build(:person) }

  describe "GET #index" do
    subject { get :index }

    it { is_expected.to render_template :index }
    it { is_expected.to be_successful }
  end

  describe "GET #show" do
    subject { get :show, params: { id: person } }

    let(:person) { FactoryGirl.create :person }

    it { is_expected.to render_template :show }
    it { is_expected.to be_successful }
  end

  describe "GET #new" do
    subject { get :new }

    it { is_expected.to render_template :new }
    it { is_expected.to be_successful }
  end

  describe "GET #edit" do
    subject { get :edit, params: { id: person } }

    let(:person) { FactoryGirl.create :person }

    it { is_expected.to render_template :edit }
    it { is_expected.to be_successful }
  end

  describe "POST #create" do
    subject { post :create, params: { person: params } }

    context 'valid params' do
      let(:params) { FactoryGirl.attributes_for(:person) }

      it { is_expected.to redirect_to Person.last }

      it "is expected to be successful" do
        expect(response).to be_success
      end

      it "is expected to change person count +1" do
        expect { subject }.to change(Person, :count).by(1)
      end
    end

    context 'invalid params' do
      let(:params) { FactoryGirl.attributes_for(:person, first_name: nil) }

      it { is_expected.to render_template :new }
      it { is_expected.to be_success }

      it "is expected to not change person count" do
        expect { subject }.to_not change(Person, :count)
      end
    end
  end

  describe "PATCH #update" do
    let(:person) { FactoryGirl.create(:person) }
    subject { put :update, params: { id: person, person: params } }

    context "changing name" do
      let(:params) { { first_name: 'Jane' } }

      it { is_expected.to redirect_to person }

      it "should update person" do
        expect { subject }
          .to change { person.reload.first_name }
          .from('John')
          .to('Jane')
      end
    end

    context "invalid attributes" do
      let(:params) { { first_name: nil } }

      it { is_expected.to render_template :edit }

      it "shouldn't update person" do
        expect { subject }
          .to_not change { person.reload.first_name }
          .from('John')
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:person) { FactoryGirl.create(:person) }
    subject { delete :destroy, params: { id: person } }

    it { is_expected.to redirect_to people_url }

    it "changes person count by -1" do
      expect { subject }.to change(Person, :count).by(-1)
    end
  end
end
