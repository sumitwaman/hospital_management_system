class RemoveColumnMedicalHistory < ActiveRecord::Migration[7.1]
  def change
    remove_column :patients, :medical_history
  end
end
