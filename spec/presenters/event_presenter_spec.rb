require 'rails_helper'

RSpec.describe EventPresenter do
  subject { described_class.new(event, nil) }
  let(:event) do
    FactoryGirl.build(:event, name: 'gucci', date: Date.new(2017))
  end

  describe '#display_name' do
    it 'returns the name and event in a reasonable text output' do
      expect(subject.display_name).to eq("gucci - 2017-01-01")
    end
  end
end
