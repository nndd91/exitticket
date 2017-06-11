require 'rails_helper'

RSpec.describe FormsController, type: :controller do
  context 'user not signed in' do
    before do
      get :new
    end

    it { expect(response).to redirect_to new_user_session_path }
  end


  context 'admin signed in' do
    let(:admin) { create(:user, :admin) }

    before do
      sign_in admin
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      let(:form_template) { create(:form_template, user: admin) }
      let!(:forms) { create_list(:form, 3, form_template: form_template, user: admin) }

      before do
        get :show, params: { id: forms[0] }
      end

        it { expect(response).to have_http_status(:success) }
    end

    describe "post #create" do
      let(:form_template) { create(:form_template, user: admin) }

      before do
        post :create, params: { form: params }
      end

      context 'save successful' do
        let(:params) { attributes_for(:form, form_template_id: form_template.id) }
        it { expect(Form.count).to eq(1) }
        it { expect(response).to redirect_to form_path(Form.last)}
      end

      context 'save failure' do
        let(:params) { attributes_for(:form, :invalid) }
        it { expect(Form.count).to eq(0) }
        it { expect(response).to render_template(:new) }
      end
    end

    describe "GET #destroy" do
      let(:form_template) { create(:form_template, user: admin) }
      let!(:forms) { create_list(:form, 3, form_template: form_template, user: admin) }

      before do
        delete :destroy, params: { id: forms[0] }
      end

      it { expect(Form.count).to eq(2) }
      it { expect(response).to redirect_to forms_path }
    end

    describe "post #update" do
      let(:form_template) { create(:form_template, user: admin) }
      let!(:forms) { create_list(:form, 3, form_template: form_template, user: admin) }

      before do
        post :update, params: { form: params, id: forms[0].id }
      end
      let(:params) { attributes_for(:form, title: "New Title!")}
      it { expect(assigns(:form).title).to eq("New Title!")}
    end

    describe "GET #edit" do
      let(:form_template) { create(:form_template, user: admin) }
      let!(:forms) { create_list(:form, 3, form_template: form_template, user: admin) }

      before do
        get :edit, xhr: true, params: { id: forms[0] }
      end

      it { expect(response).to render_template(:edit) }
      it { expect(assigns(:form)).to eq(forms[0]) }
    end

    describe 'get status' do
      #Implementing soon...
    end

    describe 'get results' do
      #Implementing soon...
    end

  end

  context 'user signed in' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe "GET #index" do
      let(:form_template) { create(:form_template, user: user) }
      let!(:forms) { create_list(:form, 3, form_template: form_template, user: user) }

      before do
        get :index
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:forms)).to match_array(forms)}
    end

    describe "GET #attempt" do
      let(:form_template) { create(:form_template, user: user) }
      let!(:forms) { create_list(:form, 3, form_template: form_template, user: user) }

      before do
        get :attempt, params: { id: forms[0] }
      end
      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:form)).to eq(forms[0]) }
    end

    describe 'attempting' do
      let(:form_template) { create(:form_template, user: user) }
      let!(:questions) { create_list(:question, 3, form_template: form_template) }
      let!(:question) { create(:question, form_template: form_template, required: false ) }
      let(:form) { create(:form, form_template: form_template) }

      before do
        post :attempting, params: { id: form, form: params }
      end

      context 'Test basic databse' do
        let(:params){ attributes_for(:form) }
        it { expect(User.count).to eq(2) }
        it { expect(FormTemplate.count).to eq(1) }
        it { expect(Question.count).to eq(4) }
        it { expect(assigns(:form)).to eq(form) }
        it { expect(Form.count).to eq(1) }
        it { expect(form.questions.count).to eq(4) }
      end
      context 'Filling all fields' do
        let(:params) { attributes_for(:form, q1: "answer1", q2: "answer2", q3: "answer3", q4: "answer4") }
        it { expect(Answer.count).to eq(4) }
        it { expect(Log.count).to eq(1) }
        it { expect(Answer.all[0].content).to eq("answer1") }
        it { expect(Answer.all[1].content).to eq("answer2") }
        it { expect(Answer.all[2].content).to eq("answer3") }
        it { expect(Answer.all[3].content).to eq("answer4") }
      end

      context 'Filling all required fields' do
        let(:params) { attributes_for(:form, q1: "answer1", q2: "answer2", q3: "answer3") }
        it { expect(Answer.count).to eq(4) }
        it { expect(Answer.all[0].content).to eq("answer1") }
        it { expect(Answer.all[1].content).to eq("answer2") }
        it { expect(Answer.all[2].content).to eq("answer3") }
        it { expect(Answer.all[3].content).to eq(nil) }
        it { expect(Log.count).to eq(1) }
      end

      context 'Missing one required field' do
        let(:params) { attributes_for(:form, q1: "answer1", q2: "answer2", q4: "answer4") }
        it { expect(Answer.count).to eq(0) }
        it { expect(assigns(:invalid_fields)).to eq([questions[2].id])}
        it { expect(assigns(:values_cache)).to eq(["answer1", "answer2", nil, "answer4"]) }
        it { expect(response).to redirect_to attempt_form_path(invalid_fields: [questions[2].id], values_cache: ["answer1", "answer2", nil, "answer4"])}
      end
    end
  end
end
