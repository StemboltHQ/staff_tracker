require 'rails_helper'

RSpec.describe PersonPolicy do
  describe '#admin?' do
    subject { described_class.new(person, 'any object').admin? }
    context 'the person is not signed in' do
      let(:person) { nil }
      it { is_expected.to eq(false) }
    end

    context 'the person is a non admin' do
      let(:person) { FactoryGirl.create(:person) }
      it { is_expected.to eq(false) }
    end

    context 'the person is an admin' do
      let(:person) { FactoryGirl.create(:person, :admin) }
      it { is_expected.to eq(true) }
    end
  end
end
