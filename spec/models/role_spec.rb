require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { FactoryGirl.create(:role) }

  describe 'validations' do
    it { is_expected. to validate_presence_of :name }
    it { is_expected. to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected. to be_valid }

    it { is_expected. to have_many :person_roles }
    it { is_expected. to have_many(:people).through(:person_roles) }

    it 'expects name to be stored lower-case' do
      subject.name = "EVeNt Planner"
      subject.save
      expect(subject.name).to eq(subject.name.downcase)
    end
  end
end
