class Appointment < ApplicationRecord

  #ASSOCIATIONS
  belongs_to :doctor
  belongs_to :patient

  #VALIDATIONS
  validates :status, :date, :time, presence: true
  validates :date, comparison: { greater_than: Time.now.to_date - 1 }
  validates :status, inclusion: { in: %w(Scheduled Completed Canceled),
    message: "%{value} is not a valid status" }

  validate :doctor_availability

  def doctor_availability
    if doctor.appointments.where(date: date, time: time).exists?
      errors.add(:time, "is already taken by another appointment for this doctor")
    end
  end
end
