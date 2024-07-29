class RemoveStatusFromAppointment < ActiveRecord::Migration[7.1]
  def change
    remove_column :appointments, :status
  end
end
