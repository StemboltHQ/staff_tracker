require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { FactoryGirl.create(:person) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to have_secure_password }
    it { is_expected.to be_valid }
    it { is_expected.to have_many(:roles) }

    it "expects first_name to be longer than 1 character" do
      subject.first_name = "A"
      expect(subject).to_not be_valid
    end

    it "expects emails to be stored lower-case" do
      subject.email = "GreG@StemBolt.CoM"
      subject.save
      expect(subject.email).to eq(subject.email.downcase)
    end

    it "expects gender to be stored lower-case" do
      subject.save
      expect(subject.gender).to eq(subject.gender.downcase)
    end
  end

  describe 'admin?' do
    subject { person.admin? }
    context 'the person has an admin role assigned' do
      let(:person) { FactoryGirl.create(:person, :admin) }
      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
    context 'the person doesnt have an admin role assigned' do
      let(:person) { FactoryGirl.create(:person) }
      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end
end
