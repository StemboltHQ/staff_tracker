require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :model do
  policy_methods = [
    :create?,
    :new?,
    :update?,
    :edit?,
    :destroy?
  ]

  context 'the person is not signed in' do
    subject { ApplicationPolicy.new(nil_person, 'any object') }
    let(:nil_person) { nil }

    policy_methods.each do |method|
      describe method.to_s do
        it 'returns false' do
          expect(subject.send(method)).to eq(false)
        end
      end
    end
  end

  context 'the person is an admin' do
    subject { ApplicationPolicy.new(admin, 'any object') }
    let(:admin) { FactoryGirl.build(:person, :admin) }

    policy_methods.each do |method|
      describe method.to_s do
        it 'returns true' do
          expect(subject.send(method)).to eq(true)
        end
      end
    end
  end

  context 'the person is a non admin' do
    subject { ApplicationPolicy.new(non_admin, 'any object') }
    let(:non_admin) { FactoryGirl.build(:person) }

    policy_methods.each do |method|
      describe method.to_s do
        it 'returns false' do
          expect(subject.send(method)).to eq(false)
        end
      end
    end
  end
end
