require 'rails_helper'

RSpec.describe PresentationPolicy, type: :model do
  policy_methods = [
    :create?,
    :new?
  ]

  describe PresentationPolicy do
    it 'inherits from ApplicationPolicy' do
      expect(described_class).to be < ApplicationPolicy
    end

    context 'the person is not signed in' do
      subject { PresentationPolicy.new(nil_person, 'any_object') }
      let(:nil_person) { nil }

      policy_methods.each do |method|
        describe method.to_s do
          it 'returns false' do
            expect(subject.send(method)).to eq(false)
          end
        end
      end
    end

    context 'the person is a non admin' do
      subject { PresentationPolicy.new(non_admin, 'any_object') }
      let(:non_admin) { FactoryGirl.build(:person) }

      policy_methods.each do |method|
        describe method.to_s do
          it 'returns true' do
            expect(subject.send(method)).to eq(true)
          end
        end
      end
    end
  end
end
