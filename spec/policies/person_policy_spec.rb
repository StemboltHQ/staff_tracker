require 'rails_helper'

RSpec.describe PersonPolicy do
  describe '#admin?' do
    subject { described_class.new(person, 'any object').admin? }
    context 'the person is not signed in' do
      let(:person) { nil }
      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'the person is a non admin' do
      let(:person) { FactoryGirl.build(:person) }
      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'the person is an admin' do
      let(:person) { FactoryGirl.build(:person, :admin) }
      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
  end
end
