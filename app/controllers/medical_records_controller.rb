# frozen_string_literal: true

# Medical_record_controller
class MedicalRecordsController < ApplicationController
  before_action :set_medical_record, only: %i[show edit update destroy]
  before_action :set_patients_and_doctors, only: %i[new edit]

  def index
    @medical_records = MedicalRecord.all
  end

  def show; end

  def new
    @medical_record = MedicalRecord.new
    # @patients = Patient.all
    # @doctors = Doctor.all
  end

  def create
    @medical_record = MedicalRecord.new(medical_record_params)
    if @medical_record.save
      redirect_to @medical_record
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @medical_record.update(medical_record_params)
      redirect_to @medical_record
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medical_record.destroy
    redirect_to medical_records_path
  end

  private

  def set_medical_record
    @medical_record = MedicalRecord.find(params[:id])
  end

  def medical_record_params
    params.require(:medical_record).permit(:patient_id, :doctor_id, :diagnosis, :prescription, :date)
  end

  def set_patients_and_doctors
    @patients = Patient.all
    @doctors = Doctor.all
  end
end
