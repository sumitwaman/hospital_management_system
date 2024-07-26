require 'rails_helper'

RSpec.describe Doctor, type: :model do

  describe 'associtation' do
    it { expect(Doctor.reflect_on_association(:appointments).macro).to eq(:has_many) }
    it { expect(Doctor.reflect_on_association(:medical_records).macro).to eq(:has_many) }
  end

  describe 'validations' do
    it 'is valid with the all agruments given according to the validations' do
      doctor = Doctor.new(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      expect(doctor).to be_valid
    end

    it 'is not valid without name' do
      doctor = Doctor.new(contact_number: '9090909090', specialty: 'Cardio')
      expect(doctor).not_to be_valid
    end

    it 'is not valid without contact number' do
      doctor = Doctor.new(name: 'Balaji',specialty: 'Cardio')
      expect(doctor).not_to be_valid
    end

    it 'is not valid without specialty' do
      doctor = Doctor.new(name: 'Balaji', contact_number: '9090909090')
      expect(doctor).not_to be_valid
    end
  end
end
