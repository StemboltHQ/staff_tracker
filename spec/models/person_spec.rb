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

  describe '#toggle_admin!' do
    subject { person.toggle_admin! }
    context 'the person has an admin role assigned' do
      let(:person) { FactoryGirl.create(:person, :admin) }
      it 'toggles the person to a non admin' do
        expect { subject }.to change { person.admin? }.from(true).to(false)
      end
    end

    context 'the person doesnt have an admin role assigned' do
      let(:person) { FactoryGirl.create(:person) }
      context 'the admin role doesnt exist yet' do
        it 'creates an admin role to assign' do
          expect { subject }.to change { Role.where(name: 'admin').count }
            .from(0)
            .to(1)
        end
        it 'toggles the person to an admin' do
          expect { subject }.to change { person.admin? }.from(false).to(true)
        end
      end

      context 'the admin role already exists' do
        before { FactoryGirl.create(:role, :admin) }
        it 'doesnt create an extra admin role' do
          expect { subject }.not_to change { Role.where(name: 'admin').count }
            .from(1)
        end
        it 'toggles the person to an admin' do
          expect { subject }.to change { person.admin? }.from(false).to(true)
        end
      end
    end
  end
end
