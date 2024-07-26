# frozen_string_literal: true

# PatientsController
class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy]

  def index
    @patients = Patient.all
  end
  
  def show; end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    respond_to do |format|
      if @patient.save
        flash[:notice] = 'Patient created successfully.'
        format.html { redirect_to @patient, notice: 'Patient created successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @patient.update(patient_params)
        flash[:notice] = 'Patient updated successfully.'
        format.html { redirect_to @patient, notice: 'Patient updated successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @patient.destroy
        format.html { redirect_to patients_path, notice: 'Patient deleted successfully' }
      else
        format.html { redirect_to @patient, alert: 'Unable to delete the patient'}
      end
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :date_of_birth, :address, :contact_number)
  end

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
