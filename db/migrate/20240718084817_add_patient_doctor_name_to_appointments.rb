class AddPatientDoctorNameToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :patient_name, :string
    add_column :appointments, :doctor_name, :string
  end
end
