class CreateDoctorsPatientsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :doctors, :patients
  end
end
