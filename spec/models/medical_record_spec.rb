require 'rails_helper'

RSpec.describe MedicalRecord, type: :model do

  describe 'associtation' do
    it { expect(MedicalRecord.reflect_on_association(:patient).macro).to eq(:belongs_to) }
    it { expect(MedicalRecord.reflect_on_association(:doctor).macro).to eq(:belongs_to) }
  end

  describe 'validations' do
    it 'is valid when all agrs are valid' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      medical_record = MedicalRecord.new(patient: patient, doctor: doctor, prescription: 'xyz', diagnosis: 'asd', date: Date.today)
      expect(medical_record).to be_valid
    end

    it 'is not valid when date is not present' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      medical_record = MedicalRecord.new(patient: patient, doctor: doctor, prescription: 'xyz', diagnosis: 'asd')
      expect(medical_record).not_to be_valid
    end

    it 'is not valid when diagnosis is not present' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      medical_record = MedicalRecord.new(patient: patient, doctor: doctor, prescription: 'xyz',date: Date.today)
      expect(medical_record).not_to be_valid
    end

    it 'is invalid when doctor is not present' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      medical_record = MedicalRecord.new(patient: patient, prescription: 'xyz', diagnosis: 'asd', date: Date.today)
      expect(medical_record).not_to be_valid
    end

    it 'is invalid when patient is not present' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      medical_record = MedicalRecord.new(doctor: doctor, prescription: 'xyz', diagnosis: 'asd', date: Date.today)
      expect(medical_record).not_to be_valid
    end

    it 'is invalid for future date' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      medical_record = MedicalRecord.new(patient: patient, doctor: doctor, prescription: 'xyz', diagnosis: 'asd', date: Date.tomorrow)
      expect(medical_record).not_to be_valid
    end
  end
end
