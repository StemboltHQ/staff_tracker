require 'rails_helper'

describe PersonMailer do
  describe '.presentation_notification' do
    let(:person) { FactoryGirl.create(:person) }
    subject do
      described_class.presentation_notification(person, Date.current).deliver
    end

    it 'greets the presenter' do
      expect(subject.body).to include("Greetings")
    end
  end
end
