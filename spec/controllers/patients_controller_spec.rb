require 'rails_helper'
  
RSpec.describe PatientsController, type: :controller do
  describe 'GET index' do
    before do
      @patient = Patient.create(name: 'abc', contact_number: '1234567890', date_of_birth: '23-10-2002', address: 'nagar')
      get :index
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

    it 'gives a successful response' do
      expect(response).to be_successful
    end
  end

  describe 'GET show' do
    before do
      @patient = Patient.create(name: 'abc', contact_number: '1234567890', date_of_birth: '23-10-2002', address: 'nagar')
      get :show, params: { id: @patient.to_param }
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

    it 'assigns to @book' do
      expect(assigns(:patient)).to eq(@patient)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET edit' do
    before do
      @patient = Patient.create(name: 'abc', contact_number: '1234567890', date_of_birth: '23-10-2002', address: 'nagar')
      get :edit, params: { id: @patient.to_param }
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

    it 'assigns to @book' do
      expect(assigns(:patient)).to eq(@patient)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET new' do
    before do
      get :new
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

  describe 'POST create' do
    context 'when parameters valid' do
      it 'creates a new patient' do
        expect {
          post :create, params: { patient: valid_params }
        }.to change(Patient, :count).by(1)
      end

      it 'redirect to created patient' do
        post :create, params: { patient: valid_params }
        expect(response).to redirect_to(Patient.last)
      end

      it 'returns the status code found as redirection' do
        post :create, params: { patient: valid_params }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        post :create, params: { patient: valid_params }
        # debugger
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      it 'does not create a new patient' do
        expect {
          post :create, params: {patient: invalid_params}
        }.to change(Patient, :count).by(0)
      end

      it 'redirect to new template' do
        post :create, params: { patient: invalid_params }
        expect(response).to render_template('new')
      end

      it 'returns the status code unprocessable entity ' do
        post :create, params: { patient: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the patient' do
        post :create, params: { patient: invalid_params }
        expect(assigns(:patient).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        post :create, params: { patient: invalid_params }
        expect(assigns(:patient).errors.full_messages).to eq(["Address can't be blank", "Address is too short (minimum is 2 characters)"])
      end
    end
  end

  describe 'PATCH update' do
    context 'when parameters valid' do
      it 'update a patient' do
        patient = Patient.create(valid_params)
        expect {
          patch :update, params: { patient: valid_params_for_update, id: patient.to_param }
        }.to change(Patient, :count).by(0)
      end

      it 'redirect to updated patient' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: valid_params_for_update, id: patient.to_param }
        expect(response).to redirect_to(patient)
      end

      it 'returns the status code found as redirection' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: valid_params_for_update, id: patient.to_param }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: valid_params_for_update, id: patient.to_param }
        # debugger
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      it 'does not update a patient' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: invalid_params_for_update, id: patient.to_param }
        expect(assigns(:patient)).to eq(patient)
      end

      it 'redirect to edit template' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: invalid_params_for_update, id: patient.to_param }
        expect(response).to render_template('edit')
      end

      it 'returns the status code unprocessable entity ' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: invalid_params_for_update, id: patient.to_param }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the patient' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: invalid_params_for_update , id: patient.to_param }
        expect(assigns(:patient).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        patient = Patient.create(valid_params)
        patch :update, params: { patient: invalid_params_for_update, id: patient.to_param }
        expect(assigns(:patient).errors.full_messages).to eq(["Name Only letters are allowed", "Contact number is the wrong length (should be 10 characters)", "Contact number is not a number"]
        )
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the patient' do
      patient = Patient.create(valid_params)
      expect { delete :destroy, params: { id: patient.to_param } }.to change(Patient, :count).by(-1)
    end

    it 'redirect to all patients list' do
      patient = Patient.create(valid_params)
      delete :destroy, params: { id: patient.to_param }
      expect(response).to redirect_to(:patients)
    end
  end

  def valid_params
    {
      name: 'abc',
      contact_number: '1234567890',
      date_of_birth: '23-10-2002',
      address: 'nagar'
    }
  end

  def valid_params_for_update
    params =
      {
        name: 'asad',
        contact_number: '1237567890',
        date_of_birth: '23-11-2002',
        address: 'nagar_pune'
      }
    params
  end

  def invalid_params
    params =
      {
        name: 'abc',
        contact_number: '1234567890',
        date_of_birth: '23-10-2002'
      }
    params
  end

  def invalid_params_for_update
    params =
      {
        name: 'abc4',
        contact_number: 'a1234567890',
        date_of_birth: '23-10-2002'
      }
    params
  end
end
