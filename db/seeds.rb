# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


#17/07/2024
# See schema


p = Patient.create(name: "pone", address: "nagar", contact_number: "1010101010", date_of_birth: "10-10-2000")
d = Doctor.create(name: "done", specialty: "Cardio", contact_number: "1010101010")
appnt = Appointment.create(patient: p, doctor: d, date: Date.today, time:Time.new(2023, 1, 1, 22, 0, 0), status: "Scheduled")


