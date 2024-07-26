# frozen_string_literal: true

# Doctor_Controller
class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show edit destroy update]

  def index
    @doctors = Doctor.all
  end

  def show; end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    respond_to do |format|
      if @doctor.save
        flash[:notice] = 'Doctor created successfully.'
        format.html { redirect_to @doctor, notice: 'Doctor created successfully.' }
      else
        flash[:notice] = 'Unable to create a doctor'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        flash[:notice] = 'Doctor updated successfully.'
        format.html { redirect_to @doctor, notice: 'Doctor updated successfully.' }
      else
        flash[:alert] = 'Unable to update the doctor'
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @doctor.destroy
        flash[:notice] = 'Doctor deleted successfully'
        format.html { redirect_to doctors_path, notice: 'Doctor deleted successfully' }
      else
        flash[:alert] = 'Unable to delete the doctor'
        format.html { redirect_to @doctor, alert: 'Unable to delete the doctor' }
      end
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :specialty, :contact_number)
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
