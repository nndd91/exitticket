require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  context 'User not signed in' do
    let(:user) { create(:user) }
    let(:form_template) { create(:form_template, user: user) }
    let(:question) { create(:question, form_template: form_template)}
    before do
      delete :destroy, params: { formtemplate_id: form_template.id, id: question }
    end

    it { expect(response).to redirect_to(new_user_session_path)}

  end

  context 'admin signed in' do
    let(:admin) { create(:user, :admin) }
    let(:form_template) { create(:form_template, user: admin) }
    let!(:question) { create(:question, form_template: form_template) }

    before do
      sign_in admin
    end

    describe "GET #edit" do

      before do
        get :edit, params: { id: question.id, formtemplate_id: form_template.id }
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:question)).to eq(question) }

    end

    describe "post #update" do

      before do
        post :update, params: { id: question.id, formtemplate_id: form_template.id, question: params }
      end

      let(:params) { attributes_for(:question, label: "New Label!") }
      it { expect(assigns(:formtemplate)).to eq(form_template) }
      it { expect(assigns(:question)).to eq(question) }
      it { expect(response).to redirect_to formtemplate_path(id: form_template) }
      it { expect(assigns(:question).label).to eq("New Label!")}

    end

    describe "GET #create" do

      before do
        post :create, xhr: true, params: { formtemplate_id: form_template.id, question: params }
      end

      context 'save success' do
        let(:params) { attributes_for(:question) }
        it { expect(response).to render_template(:create) }
        it { expect(Question.count).to eq(2) }
        it { expect(assigns(:formtemplate)).to eq(form_template) }
        it { expect(assigns(:question)).to be_valid }
      end

      context 'save fails' do

      end

    end

    describe "GET #destroy" do

      before do
        get :destroy, xhr: true, params: {formtemplate_id: form_template.id, id: question.id }
      end

      it { expect(response).to render_template(:destroy) }
      it { expect(Question.count).to eq(0) }
      it { expect(assigns(:formtemplate)).to eq(form_template) }

    end
  end
end
