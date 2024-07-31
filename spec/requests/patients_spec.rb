require 'rails_helper'

RSpec.describe "Patients", type: :request do
  let(:valid_params) {
    { name: 'Pthirty', address: 'Nagar', contact_number: '1234567890', date_of_birth: '1990-01-01' }
  }

  let(:invalid_params) {
    { name: 'P30', address: 'Nagar', contact_number: '1234567890' }
  }


  describe 'GET /index' do
    before do
      @patient = Patient.create(valid_params)
      get patients_url
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'assigns @patients' do
      expect(assigns(:patients)).to eq([@patient])
    end

    it 'render the index template' do
      expect(response).to render_template('index')
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    before do
      @patient = Patient.create(valid_params)
      get patient_url(@patient)
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

    it 'assigns to @patient' do
      expect(assigns(:patient)).to eq(@patient)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET /edit' do
    before do
      @patient = Patient.create(valid_params)
      get edit_patient_url(@patient)
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

    it 'assigns to @patient' do
      expect(assigns(:patient)).to eq(@patient)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET new' do
    before do
      get new_patient_url
    end

    it 'returns a successfull response' do
      expect(response).to be_successful
    end

    it 'render a new template' do
      expect(response).to render_template('new')
    end

    it 'create a new patient' do
      expect(assigns(:patient)).to be_a_new(Patient)
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'when parameters valid' do
      before do
        post patients_url, params: { patient: valid_params }
      end

      it 'creates a new patient' do
        expect {
          post patients_url, params: { patient: valid_params }
        }.to change(Patient, :count).by(1)
      end

      it 'redirect to created patient' do
        expect(response).to redirect_to(Patient.last)
      end

      it 'returns the status code found as redirection' do
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      before do
        post patients_url, params: { patient: invalid_params }
      end

      it 'does not create a new patient' do
        expect {
          post patients_url, params: { patient: invalid_params }
        }.to change(Patient, :count).by(0)
      end

      it 'redirect to new template' do
        expect(response).to render_template('new')
      end

      it 'returns the status code unprocessable entity ' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the patient' do
        expect(assigns(:patient).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        expect(assigns(:patient).errors.full_messages).to eq(["Date of birth can't be blank", "Name Only letters are allowed", "Date of birth can't be blank"])
      end
    end
  end


  describe 'Patch /update' do
    let(:valid_params_update) {
      { name: 'Pthirtyupdated', address: 'Nagarupdated', contact_number: '1234567890', date_of_birth: '1990-01-01' }
    }

    let(:invalid_params_update) {
      { name: 'P30', address: 'nagar', date_of_birth: '1995-01-01', contact_number: '123abc' }
    }

    context 'when parameters are valid' do
      it 'update a patient' do
        patient = Patient.create(valid_params)
        expect {
          patch patient_url(patient), params: { patient: valid_params_update }
        }.to change(Patient, :count).by(0)
      end

      it "updates the requested patient" do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: valid_params_update }
        patient.reload
        expect(patient.name).to eq('Pthirtyupdated')
        expect(patient.address).to eq('Nagarupdated')
      end

      it 'redirect to updated patient' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: valid_params_update }
        expect(response).to redirect_to(patient)
      end

      it 'returns the status code found as redirection' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: valid_params_update }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: valid_params_update }
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      it 'does not update a patient' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: invalid_params_update }
        expect(assigns(:patient)).to eq(patient)
      end

      it 'redirect to edit template' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: invalid_params_update }
        expect(response).to render_template('edit')
      end

      it 'returns the status code unprocessable entity ' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: invalid_params_update }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the patient' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: invalid_params_update }
        expect(assigns(:patient).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        patient = Patient.create(valid_params)
        patch patient_url(patient), params: { patient: invalid_params_update }
        expect(assigns(:patient).errors.full_messages).to eq(["Name Only letters are allowed", "Contact number is the wrong length (should be 10 characters)", "Contact number is not a number"]
        )
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the patient' do
      patient = Patient.create(valid_params)
      expect { delete patient_url(patient) }.to change(Patient, :count).by(-1)
    end

    it 'redirect to all patients list' do
      patient = Patient.create(valid_params)
      delete patient_url(patient)
      expect(response).to redirect_to(:patients)
    end
  end
end
