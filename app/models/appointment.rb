class Appointment < ApplicationRecord

  #ASSOCIATIONS
  belongs_to :doctor
  belongs_to :patient

  #VALIDATIONS
  validates :date, :time, presence: true
  validates :date, comparison: { greater_than: Time.now.to_date - 1 }


  validate :doctor_availability, if: :doctor

  private

  def doctor_availability
    if doctor && doctor.appointments.where(date: date, time: time).exists?
      errors.add(:time, "is already taken by another appointment for this doctor")
    end
  end
end
