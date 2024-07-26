require 'rails_helper'

RSpec.describe Patient, type: :model do

  context 'associtations ' do
    it 'has many appointments' do
      appointment_relation = Patient.reflect_on_association(:appointments)
      expect(appointment_relation.macro).to eq(:has_many)
    end

    it 'has many medical records' do
      patient_relation = Patient.reflect_on_association(:medical_records)
      expect(patient_relation.macro).to eq(:has_many)
    end
    # it { expect(Patient.reflect_on_association(:appointments).macro).to eq(:has_many) }
    # it { expect(Patient.reflect_on_association(:medical_records).macro).to eq(:has_many) }
  end


  describe 'validations' do
    context 'when correct inputs are provided' do
      it 'is valid when all arguments are given according to validations' do
        patient = Patient.new(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
        expect(patient).to be_valid
      end
    end

    context 'when incorrect inputs are provided'
      it 'is not valid without name' do
        patient = Patient.new(address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
        expect(patient).not_to be_valid
      end

      it 'is not valid without address' do
        patient = Patient.new(name: 'Sumit', contact_number: '1234567890', date_of_birth: '23-10-2002')
        expect(patient).not_to be_valid
      end

      it 'is not valid without DOB' do
        patient = Patient.new(name: 'Sumit', address: 'Nagar', contact_number: '1234567890')
        expect(patient).not_to be_valid
      end

      it 'is not valid without contact_number' do
        patient = Patient.new(name: 'Sumit', address: 'Nagar', date_of_birth: '23-10-2002')
        expect(patient).not_to be_valid
      end

      it 'is invalid for the future date of birth' do
        patient = Patient.new(name: 'Sumit', address: 'Nagar', contact_number: '1234567890',  date_of_birth: '23-10-2024')
        expect(patient).not_to be_valid
      end

      it 'is invalid for the name containing other than the letters' do
        patient = Patient.new(name: 'Sumit1', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2024')
        expect(patient).not_to be_valid
      end

      it 'will invalid if contact number is greater or less than 10 digits' do
        patient = Patient.new(name: 'Sumit', address: 'Nagar', contact_number: '123456789011', date_of_birth: '23-10-2024')
        expect(patient).not_to be_valid
      end
    end
  end
