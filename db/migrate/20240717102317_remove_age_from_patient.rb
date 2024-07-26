class RemoveAgeFromPatient < ActiveRecord::Migration[7.1]
  def change
    remove_column :patients, :age
  end
end
