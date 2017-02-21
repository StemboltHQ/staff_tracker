# spec/controllers/people_controller_spec.rb
require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it "renders the template" do
      expect(subject).to render_template(:index)
    end
    it "loads all of the people into @people" do
      expect(subject.body.length).to be_truthy
    end
  end

  describe "GET #show" do
    subject { get :show, params: { id: person } }

    let(:person) { FactoryGirl.create :person }

    it "renders the template" do
      expect(subject).to render_template(:show)
    end
  end

  describe "GET #new" do
    subject { get :new }

    it "renders the template" do
      expect(subject).to render_template :new 
    end
  end

  describe "GET #edit" do
    subject { get :edit, params: { id: person } }
    let(:person) { FactoryGirl.create :person }

    it "renders the template" do
      expect(subject).to render_template :edit
    end

  end

  describe "POST #create" do
    subject { post :create, params: { person: params } }
    let(:params) { FactoryGirl.attributes_for(:person) }

    it "changes person count by +1" do
      expect { subject }.to change(Person, :count).by(1)
    end

    it "loads the person into @person" do
      expect(subject).to redirect_to(Person.last)
    end

    context "with invalid attributes" do
      let(:params) { FactoryGirl.attributes_for(:person, first_name: nil) }

      it "does not save the new person" do
        expect{ subject }.to_not change(Person, :count)
      end

      it "re-runs people#new" do
        expect(subject).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let(:person) { FactoryGirl.create(:person) }
    subject { put :update, params: { id: person, person: params } }

    context "changing name" do 
      let(:params) { { first_name: 'Jane' } }

      it "should update person" do
        expect { subject }.to change { person.reload.first_name }.from('John').to('Jane')
      end

      it "renders the template" do
        expect(subject).to redirect_to(@person)
      end
    end

    context "invalid attributes" do
      let(:params) { { first_name: nil } }
      it "shouldn't update person" do
        expect { subject }.to_not change { person.reload.first_name }.from('John')
      end
      it "renders the template" do
        expect(subject).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:person) { FactoryGirl.create(:person) }
    subject { delete :destroy, params: { id: person } }

    it "changes person count by -1" do
      expect { subject }.to change(Person, :count).by(-1)
    end
    it "renders the people#index template" do
      expect(subject).to redirect_to people_url
    end
  end
end
