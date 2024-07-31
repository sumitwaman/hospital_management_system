require 'rails_helper'

RSpec.describe "MedicalRecords", type: :request do
  let(:valid_patient) { Patient.create(name: 'Peleven', contact_number: '1234567890', date_of_birth: '1990-01-01', address: 'Nagar') }
  let(:valid_doctor) { Doctor.create(name: 'Deleven', specialty: 'Cardiology', contact_number: '0987654321') }

  let(:valid_params) {
    {
      date: Date.today,
      diagnosis: 'Flu',
      prescription: 'Paracetamol',
      patient_id: valid_patient.id
    }
  }

  before do
    @medical_record = valid_doctor.medical_records.create(valid_params)
  end

  describe 'GET index' do
    before do
      get doctor_medical_records_url(valid_doctor)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'assigns @medical_record' do
      expect(assigns(:medical_records)).to eq(valid_doctor.medical_records)
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
      get doctor_medical_record_path(valid_doctor, @medical_record.id)
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

    it 'assigns to @medical_record' do
      expect(assigns(:medical_record)).to eq(@medical_record)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET edit' do
    before do
      get edit_doctor_medical_record_url(valid_doctor, @medical_record.id)
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
      expect(assigns(:medical_record)).to eq(@medical_record)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET new' do
    before do
      get new_doctor_medical_record_path(valid_doctor)
    end

    it 'returns a successfull response' do
      expect(response).to be_successful
    end

    it 'render a new template' do
      expect(response).to render_template('new')
    end

    it 'create a new doctor' do
      expect(assigns(:medical_record)).to be_a_new(MedicalRecord)
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    context 'when parameters valid' do
      let(:valid_params_post){
        {
          date: Date.today,
          diagnosis: 'Flu',
          prescription: 'Paracetamol',
          patient_id: valid_patient.id
        }
      }

      it 'creates a new medical record' do
        expect {
          post doctor_medical_records_path(valid_doctor), params: { medical_record: valid_params_post }
        }.to change(MedicalRecord, :count).by(1)
      end

      it 'redirect to created medical record' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: valid_params_post }
        expect(response).to redirect_to doctor_medical_records_path(valid_doctor)
      end

      it 'returns the status code found as redirection' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: valid_params_post }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: valid_params_post }
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      let(:invalid_params_post){
        {
          date: Date.today,
          diagnosis: nil,
          patient_id: valid_patient.id
        }
      }

      it 'does not create a new medical record' do
        expect {
          post doctor_medical_records_path(valid_doctor), params: { medical_record: invalid_params_post }
        }.to change(MedicalRecord, :count).by(0)
      end

      it 'redirect to new template' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: invalid_params_post }
        expect(response).to render_template('new')
      end

      it 'returns the status code unprocessable entity ' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: invalid_params_post }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the medical record' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: invalid_params_post }
        expect(assigns(:medical_record).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        post doctor_medical_records_path(valid_doctor), params: { medical_record: invalid_params_post }
        expect(assigns(:medical_record).errors.full_messages).to eq(["Diagnosis can't be blank", "Prescription can't be blank", "Diagnosis is too short (minimum is 2 characters)", "Prescription is too short (minimum is 2 characters)"]
        )
      end
    end
  end

  describe 'PATCH update' do
    context 'when parameters valid' do
      let(:valid_params_update){
        {
          date: Date.today,
          diagnosis: 'Fluupdated',
          prescription: 'Paracetamolupdated',
          patient_id: valid_patient.id
        }
      }

      it 'update a medical record' do
        expect {
          patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: valid_params_update }
        }.to change(MedicalRecord, :count).by(0)
      end

      it 'updates the requested medical record' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: valid_params_update }
        @medical_record.reload
        expect(@medical_record.diagnosis).to eq('Fluupdated')
        expect(@medical_record.prescription).to eq('Paracetamolupdated')
      end

      it 'redirect to updated medical record' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: valid_params_update }
        expect(response).to redirect_to doctor_medical_record_path(valid_doctor)
      end

      it 'returns the status code found as redirection' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: valid_params_update }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: valid_params_update }
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      let(:invalid_params_update){
        {
          date: Date.today,
          diagnosis: nil,
          patient_id: valid_patient.id
        }
      }

      it 'does not update an medical record' do
        expect {
          patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: invalid_params_update }
        }.to change(MedicalRecord, :count).by(0)
      end

      it 'redirect to edit template' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: invalid_params_update }
        expect(response).to render_template('edit')
      end

      it 'returns the status code unprocessable entity ' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: invalid_params_update }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the medical record' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: invalid_params_update }
        expect(assigns(:medical_record).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        patch doctor_medical_record_path(valid_doctor, @medical_record.id), params: { medical_record: invalid_params_update }
        expect(assigns(:medical_record).errors.full_messages).to eq(["Diagnosis can't be blank", "Diagnosis is too short (minimum is 2 characters)"]
        )
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the medical record' do
      expect {
        delete doctor_medical_record_path(valid_doctor, @medical_record.id)
      }.to change(MedicalRecord, :count).by(-1)
    end

    it 'redirect to all medical records list' do
      delete doctor_medical_record_path(valid_doctor, @medical_record.id)
      expect(response).to redirect_to doctor_medical_records_path(valid_doctor)
    end
  end
end
