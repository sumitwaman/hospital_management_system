class Doctor < ApplicationRecord

  #ASSOCIATIONS

  has_many :appointments
  has_many :medical_records

  #VALIDATIONS
  validates :name, :specialty, :contact_number, presence: true
  validates :name, :specialty, format: { with: /\A[a-zA-Z]+\z/ ,  message: "Only letters are allowed"}
  validates :contact_number, length: {is: 10}, presence: true, numericality: true


end
