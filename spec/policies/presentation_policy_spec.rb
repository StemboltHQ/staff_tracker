require 'rails_helper'

RSpec.describe PresentationPolicy, type: :model do
  requiring_sign_in_methods = [
    :create?,
    :new?,
    :update?,
    :edit?
  ]

  describe PresentationPolicy do
    it 'inherits from ApplicationPolicy' do
      expect(described_class).to be < ApplicationPolicy
    end

    context 'the person is not signed in' do
      subject { PresentationPolicy.new(nil_person, 'any_object') }
      let(:nil_person) { nil }

      requiring_sign_in_methods.each do |method|
        describe method.to_s do
          it 'returns false' do
            expect(subject.send(method)).to be(false)
          end
        end
      end
    end

    context 'the person is an admin' do
      subject { described_class.new(admin, presentation) }
      let(:admin) { FactoryGirl.create(:person, :admin) }
      let(:presentation) { FactoryGirl.build(:presentation) }

      describe '.update?' do
        it 'returns true' do
          expect(subject.update?).to be(true)
        end
      end

      describe '.edit?' do
        it 'calls the .update? method' do
          expect(subject).to receive(:update?)
          subject.edit?
        end
      end
    end

    context 'the person is a non admin' do
      subject { PresentationPolicy.new(non_admin, presentation) }
      let(:non_admin) { FactoryGirl.build(:person) }
      let(:presentation) { FactoryGirl.build(:presentation) }

      describe '.update?' do
        context 'the presentation being taken action on belongs to the person' do
          before do
            non_admin.presentations << presentation
          end

          it 'returns true' do
            expect(subject.update?).to eq(true)
          end
        end
        context 'the presentation being taken action on doesnt belong to the person' do
          it 'returns false' do
            expect(subject.update?).to eq(false)
          end
        end
      end

      describe '.edit?' do
        context 'the presentation being taken action on belongs to the person' do
          before do
            non_admin.presentations << presentation
          end

          it 'returns true' do
            expect(subject.update?).to eq(true)
          end
        end
        context 'the presentation being taken action on doesnt belong to the person' do
          it 'returns false' do
            expect(subject.update?).to eq(false)
          end
        end
      end
    end
  end
end
