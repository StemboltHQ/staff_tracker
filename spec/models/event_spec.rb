# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'valid attributes' do 
    describe 'name' do
      subject { FactoryGirl.create(:event, name: 'Show & Tell') }

      it "expects name to be a string" do
        expect(subject).to be_valid
      end
    end
  end

  describe 'invalid name' do
    it "expects name" do
      subject { FactoryGirl.create(:event, name: nil) }
      expect(subject).to_not be_valid
    end
  end

  describe 'invalid date' do
    it "expects date" do
      subject { FactoryGirl.create(:event, date: nil) }
      expect(subject).to_not be_valid
    end
  end

  describe 'invalid location' do
    it "expects location" do
      subject { FactoryGirl.create(:event, location: nil) }
      expect(subject).to_not be_valid
    end
  end
end
