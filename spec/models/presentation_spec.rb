# spec/models/presentation_spec.rb
require 'rails_helper'

RSpec.describe Presentation, type: :model do
  describe 'valid arrtibutes' do
    subject { FactoryGirl.create(:presentation) }

    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end
    it 'accepts date as a string' do
      subject.date = '2017/03/01'
      expect(subject).to be_valid
    end
  end

  describe 'invalid attributes' do
    it 'expects title' do
      subject { FactoryGirl.create(:presentation, title: nil) }
      expect(subject).to_not be_valid
    end
    it 'expects content' do
      subject { FactoryGirl.create(:presentation, content: nil) }
      expect(subject).to_not be_valid
    end
    it 'expects date_of_presentation' do
      subject { FactoryGirl.create(:presentation, date: nil) }
      expect(subject).to_not be_valid
    end
  end
end
