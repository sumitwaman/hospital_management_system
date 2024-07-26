class ChangeContactNumberAgain < ActiveRecord::Migration[7.1]
  def change
    change_column :patients, :contact_number, :string
    change_column :doctors, :contact_number, :string
  end
end
