# frozen_string_literal: true

# Medical_record_controller
class MedicalRecordsController < ApplicationController
  before_action :set_medical_record, only: %i[show edit update destroy]
  before_action :set_patients_and_doctors, only: %i[new edit]
  before_action :set_patient_or_doctor

  def index
    @medical_records = @patient_or_doctor.medical_records
  end

  def show; end

  def new
    @medical_record = @patient_or_doctor.medical_records.build
  end

  def create
    @medical_record = @patient_or_doctor.medical_records.build(medical_record_params)
    respond_to do |format|
      if @medical_record.save
        format.html { redirect_to [@patient_or_doctor, @medical_record], notice: 'Medical history created successfully' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @medical_record.update(medical_record_params)
        format.html { redirect_to [@patient_or_doctor, @medical_record], notice: 'Medical history updated successfully' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @medical_record.destroy
    redirect_to medical_records_path
  end

  private

  def set_medical_record
    @medical_record = @patient_or_doctor.medical_records.find(params[:id])
  end

  def medical_record_params
    params.require(:medical_record).permit(:patient_id, :doctor_id, :diagnosis, :prescription, :date)
  end

  def set_patients_and_doctors
    @patients = Patient.all
    @doctors = Doctor.all
  end

  def set_patient_or_doctor
    if params[:patient_id]
      @patient_or_doctor = Patient.find(params[:patient_id])
    elsif param[:doctor_id]
      @patient_or_doctor = Doctor.find(params[:doctor_id])
    else
      redirect_to root_path, alert: 'No doctor and patient found for appointment'
    end
  end
end
