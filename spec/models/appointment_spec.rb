require 'rails_helper'

RSpec.describe Appointment, type: :model do

  describe 'associations' do
    it { expect(Appointment.reflect_on_association(:patient).macro).to eq(:belongs_to) }
    it { expect(Appointment.reflect_on_association(:doctor).macro).to eq(:belongs_to)}
  end

  describe 'validations' do
    it 'is valid when all agrs are valid' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      appointment = Appointment.new(patient: patient, doctor: doctor, date: Date.today + 10.days, time: Time.new(2023, 1, 1, 22, 0, 0), status: 'Scheduled')
      expect(appointment).to be_valid
    end

    it 'is invalid for the empty date' do
      patient = Patient.create(name: 'Sumit', address: 'Nagar', contact_number: '1234567890', date_of_birth: '23-10-2002')
      doctor = Doctor.create(name: 'Balaji', contact_number: '9090909090', specialty: 'Cardio')
      appointment = Appointment.new(patient: patient, doctor: doctor, time: Time.new(2023, 1, 1, 22, 0, 0), status: 'Scheduled')
      expect(appointment).not_to be_valid
    end
  end
end
