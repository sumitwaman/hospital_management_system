class MedicalRecord < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :patient
  belongs_to :doctor

  #VALIDATIONS
  validates :diagnosis, :prescription, :patient_id, :doctor_id, :date, presence: true
  validates :date, comparison: { less_than: Date.today + 1 }
  validates :diagnosis, length: { minimum: 2, maximum: 200}
  validates :prescription, length: { minimum: 2, maximum: 300}
end
