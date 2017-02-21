require 'rails_helper'

RSpec.describe Person, type: :model do
  subject {
    described_class.new(
      first_name: 'Gregory',
      last_name: 'Daynes',
      email: 'greg@stembolt.com',
      password: 'abc123',
      password_confirmation: 'abc123',
      date_of_birth: Date.new(1986,11,04),
      gender: 'Male'
    )
  }

  describe "validations" do
    it "expects valid attributes" do
      expect(subject).to be_valid
    end
    it "expects first_name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end
    it "expects first_name to be longer than 1 character" do
      subject.first_name = "A"
      expect(subject).to_not be_valid
    end
    it "expects email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    it "expects valid email" do
      subject.email = "greg@stembolt"
      expect(subject).to_not be_valid
    end
    it "expects unique email" do
      duplicate_person = subject.dup
      subject.save
      expect(duplicate_person).to_not be_valid
    end
    it "expects emails to be stored lower-case" do
      subject.email = "GreG@StemBolt.CoM"
      subject.save
      expect(subject.email).to eq(subject.email.downcase)
    end
    it "expects date_of_birth" do
      subject.date_of_birth = nil
      expect(subject).to_not be_valid
    end
    it "accepts date_of_birth as Date" do
      expect(subject).to be_valid
    end
    it "accepts date_of_birth as String" do
      subject.date_of_birth = '1986/11/04'
      expect(subject).to be_valid
    end
    it "expects gender" do
      subject.gender = nil
      expect(subject).to_not be_valid
    end
    it "expects gender to be stored lower-case" do
      subject.save
      expect(subject.gender).to eq(subject.gender.downcase)
    end
    it "expects password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end
    it "expects password_confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end
    it "expects password == password_confirmation" do
      subject.password_confirmation = "123abc"
      expect(subject).to_not be_valid
    end
  end

  describe "associations" do
    it "should have one staff"
  end
end
