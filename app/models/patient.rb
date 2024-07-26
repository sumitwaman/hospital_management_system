class Patient < ApplicationRecord

  #ASSOCIATIONS
  has_many :appointments
  has_many :medical_records

  #VALIDATIONS
  validates :name, :date_of_birth, :contact_number, :address, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+\z/ ,  message: "Only letters are allowed"}
  validates :contact_number, length: { is: 10 }, presence: true, numericality: true
  validates :date_of_birth, comparison: { less_than: Time.now.to_date }
  validates :address, length: { minimum:2, maximum:100 }

end
