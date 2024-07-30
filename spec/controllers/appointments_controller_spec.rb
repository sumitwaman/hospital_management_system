require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:valid_patient) { Patient.create(name: 'Peleven', contact_number: '1234567890', date_of_birth: '1990-01-01', address: 'Nagar') }
  let(:valid_doctor) { Doctor.create(name: 'Deleven', specialty: 'Cardiology', contact_number: '0987654321') }

  let(:invalid_patient) { Patient.create(name: 'P11', date_of_birth: '1990-01-01', address: 'Nagar') }
  let(:invalid_doctor) { Doctor.create(name: 'D11', contact_number: '0987654321') }

  let(:valid_params) {
    {
      date: '2024-08-01',
      time: '14:00',
      doctor_id: valid_doctor.id
    }
  }

  before do
    @appointment = valid_patient.appointments.create(valid_params)
  end

  describe 'GET index' do
    before do
      get :index, params: { patient_id: valid_patient.id }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'assigns @appointment' do
      expect(assigns(:appointments)).to eq(valid_patient.appointments)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { patient_id: valid_patient.id, id: @appointment.id }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns to @appointment' do
      expect(assigns(:appointment)).to eq(@appointment)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { patient_id: valid_patient.id, id: @appointment.id }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns to @doctor' do
      expect(assigns(:appointment)).to eq(@appointment)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET new' do
    before do
      get :new, params: { patient_id: valid_patient.id }
    end

    it 'returns a successfull response' do
      expect(response).to be_successful
    end

    it 'render a new template' do
      expect(response).to render_template('new')
    end

    it 'create a new doctor' do
      expect(assigns(:appointment)).to be_a_new(Appointment)
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    context 'when parameters valid' do
      let(:valid_params_post){
        {
          date: '2024-08-01',
          time: '14:50',
          doctor_id: valid_doctor.id
        }
      }

      it 'creates a new appointment' do
        expect {
          post :create, params: { patient_id: valid_patient.id, appointment: valid_params_post }
        }.to change(Appointment, :count).by(1)
      end

      it 'redirect to created appointment' do
        post :create, params: { patient_id: valid_patient.id, appointment: valid_params_post }
        expect(response).to redirect_to patient_appointments_path(valid_patient)
      end

      it 'returns the status code found as redirection' do
        post :create, params: { patient_id: valid_patient.id, appointment: valid_params_post }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        post :create, params: { patient_id: valid_patient.id, appointment: valid_params_post }
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      let(:invalid_params_post){
        {
          date: nil,
          time: '14:50',
          doctor_id: valid_doctor.id
        }
      }

      it 'does not create a new appointment' do
        expect {
          post :create, params: { patient_id: valid_patient.id, appointment: invalid_params_post }
        }.to change(Appointment, :count).by(0)
      end

      it 'redirect to new template' do
        post :create, params: { patient_id: valid_patient.id, appointment: invalid_params_post }
        expect(response).to render_template('new')
      end

      it 'returns the status code unprocessable entity ' do
        post :create, params: { patient_id: valid_patient.id, appointment: invalid_params_post }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the appointment' do
        post :create, params: { patient_id: valid_patient.id, appointment: invalid_params_post }
        expect(assigns(:appointment).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        post :create, params: { patient_id: valid_patient.id, appointment: invalid_params_post }
        expect(assigns(:appointment).errors.full_messages).to eq(["Date can't be blank", "Date can't be blank"])
      end
    end
  end

  describe 'PATCH update' do
    context 'when parameters valid' do
      let(:valid_params_update){
        {
          date: '2024-08-02',
          time: '14:50',
          doctor_id: valid_doctor.id
        }
      }

      it 'update an appointment' do
        expect {
          patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: valid_params_update }
        }.to change(Appointment, :count).by(0)
      end

      it 'redirect to updated appointment' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: valid_params_update }
        expect(response).to redirect_to patient_appointment_path(valid_patient)
      end

      it 'returns the status code found as redirection' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: valid_params_update }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: valid_params_update }
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      let(:invalid_params_update){
        {
          date: nil,
          time: '14:50',
          doctor_id: valid_doctor.id
        }
      }

      it 'does not update an appointment' do
        expect {
          patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: invalid_params_update }
        }.to change(Appointment, :count).by(0)
      end

      it 'redirect to edit template' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: invalid_params_update }
        expect(response).to render_template('edit')
      end

      it 'returns the status code unprocessable entity ' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: invalid_params_update }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the appointment' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: invalid_params_update }
        expect(assigns(:appointment).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        patch :update, params: { patient_id: valid_patient.id, id: @appointment.id, appointment: invalid_params_update}
        expect(assigns(:appointment).errors.full_messages).to eq(["Date can't be blank", "Date can't be blank"])
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the appointment' do
      expect {
        delete :destroy, params: { patient_id: valid_patient.id, id: @appointment.id }
      }.to change(Appointment, :count).by(-1)
    end

    it 'redirect to all appointments list' do
      delete :destroy, params: { patient_id: valid_patient.id, id: @appointment.id }
      expect(response).to redirect_to patient_appointments_path(valid_patient)
    end
  end
end
