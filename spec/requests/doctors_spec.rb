require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  let(:valid_params) {
    {
      name: 'Dthirty',
      specialty: 'Cardio',
      contact_number: '1231231231'
    }
  }

  let(:invalid_params) {
    {
      name: 'abc4',
      contact_number: 'a1234567890'
    }
  }

  describe 'GET /index' do
    before do
      @doctor = Doctor.create(valid_params)
      get doctors_url
    end

    it 'assigns @doctors' do
      expect(assigns(:doctors)).to eq([@doctor])
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

  describe 'GET /show' do
    before do
      @doctor = Doctor.create(valid_params)
      get doctor_url(@doctor)
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

    it 'assigns to @doctor' do
      expect(assigns(:doctor)).to eq(@doctor)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET /edit' do
    before do
      @doctor = Doctor.create(valid_params)
      get edit_doctor_url(@doctor)
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
      expect(assigns(:doctor)).to eq(@doctor)
    end

    it 'should accept the params with html format' do
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end
  end

  describe 'GET new' do
    before do
      get new_doctor_url
    end

    it 'returns a successfull response' do
      expect(response).to be_successful
    end

    it 'render a new template' do
      expect(response).to render_template('new')
    end

    it 'create a new doctor' do
      expect(assigns(:doctor)).to be_a_new(Doctor)
    end

    it 'returns the status code ok' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    context 'when parameters valid' do
      before do
        post doctors_url, params: { doctor: valid_params }
      end

      it 'creates a new doctor' do
        expect {
          post doctors_url, params: { doctor: valid_params }
        }.to change(Doctor, :count).by(1)
      end

      it 'redirect to created doctor' do
        expect(response).to redirect_to(Doctor.last)
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
        post doctors_url, params: { doctor: invalid_params }
      end

      it 'does not create a new doctor' do
        expect {
          post doctors_url, params: { doctor: invalid_params }
        }.to change(Doctor, :count).by(0)
      end

      it 'redirect to new template' do
        expect(response).to render_template('new')
      end

      it 'returns the status code unprocessable entity ' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the doctor' do
        expect(assigns(:doctor).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        validations = [
          "Specialty can't be blank",
          'Name Only letters are allowed',
          'Specialty Only letters are allowed',
          'Contact number is the wrong length (should be 10 characters)',
          'Contact number is not a number'
        ]
        expect(assigns(:doctor).errors.full_messages).to eq(validations)
      end
    end
  end

  describe 'PATCH /update' do
    let(:valid_params_update) {
      {
        name: 'Dthirtyupdated',
        specialty: 'Cardiospecilty',
        contact_number: '1234567890'
      }
    }

    let(:invalid_params_update) {
      {
        name: 'abc4',
        contact_number: 'a1234567890'
      }
    }

    context 'when parameters valid' do
      it 'update a doctor' do
        doctor = Doctor.create(valid_params)
        expect {
          patch doctor_url(doctor), params: { doctor: valid_params_update }
        }.to change(Doctor, :count).by(0)
      end

      it "updates the requested doctor" do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: valid_params_update }
        doctor.reload
        expect(doctor.name).to eq('Dthirtyupdated')
      end

      it 'redirect to updated doctor' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: valid_params_update }
        expect(response).to redirect_to(doctor)
      end

      it 'returns the status code found as redirection' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: valid_params_update }
        expect(response).to have_http_status(:found)
      end

      it 'should accept the params with html format' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: valid_params_update }
        expect(response.media_type).to eq('text/html')
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end
    end

    context 'when parameters are invalid ' do
      it 'does not update a doctor' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: invalid_params_update }
        expect(assigns(:doctor)).to eq(doctor)
      end

      it 'redirect to new template' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: invalid_params_update }
        expect(response).to render_template('edit')
      end

      it 'returns the status code unprocessable entity ' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: invalid_params_update }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not validate the doctor' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: invalid_params_update }
        expect(assigns(:doctor).valid?).to_not eq(true)
      end

      it 'includes the error messages for the validated attributes' do
        doctor = Doctor.create(valid_params)
        patch doctor_url(doctor), params: { doctor: invalid_params_update }
        expect(assigns(:doctor).errors.full_messages).to eq(["Name Only letters are allowed", "Contact number is the wrong length (should be 10 characters)", "Contact number is not a number"]
        )
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the doctor' do
      doctor = Doctor.create(valid_params)
      expect { delete doctor_url(doctor) }.to change(Doctor, :count).by(-1)
    end

    it 'redirect to all doctors list' do
      doctor = Doctor.create(valid_params)
      delete doctor_url(doctor)
      expect(response).to redirect_to(:doctors)
    end
  end
end
