class AppointmentsController < ApplicationController
  before_action :set_patient_or_doctor
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    @appointments = @patient_or_doctor.appointments
  end

  def show; end

  def new
    @appointment = @patient_or_doctor.appointments.build
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def edit
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def create
    @appointment = @patient_or_doctor.appointments.build(appointment_params)
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to [@patient_or_doctor, @appointment], notice: 'Appointment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to [@patient_or_doctor, @appointment], notice: 'Appointment was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to @patient_or_doctor, notice: 'Appointment was successfully destroyed.' }
    end
  end

  private

  def set_patient_or_doctor
    if params[:patient_id]
      @patient_or_doctor = Patient.find(params[:patient_id])
    elsif params[:doctor_id]
      @patient_or_doctor = Doctor.find(params[:doctor_id])
    else
      redirect_to root_path, alert: 'No doctor and patient found for appointment'
    end
  end

  def set_appointment
    @appointment = @patient_or_doctor.appointments.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:patient_id, :doctor_id, :date, :time, :status)
  end
end
