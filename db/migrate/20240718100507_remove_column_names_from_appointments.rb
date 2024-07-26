class RemoveColumnNamesFromAppointments < ActiveRecord::Migration[7.1]
  def change
    remove_column :appointments, :patient_name
    remove_column :appointments, :doctor_name
  end
end
