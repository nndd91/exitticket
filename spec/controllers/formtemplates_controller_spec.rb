require 'rails_helper'

RSpec.describe FormtemplatesController, type: :controller do

  context 'user not signed in' do
  end

  context 'admin signed in' do
    let(:admin) { create(:user, :admin) }

    before do
      sign_in admin
    end

    describe "GET #index" do
      let(:formtemplates) { create_list(:form_template, 3, user: admin) }

      before do
        get :index
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:formtemplates)).to match_array(formtemplates) }
    end

    describe "GET #show" do
      let(:formtemplates) { create_list(:form_template, 3, user: admin) }
      let(:questions) { create_list(:question, 3, form_template: formtemplates[0]) }

      before do
        get :show, params: { id: formtemplates[0] }
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:formtemplate)).to eq(formtemplates[0]) }
      it { expect(assigns(:questions)).to match_array(questions)}

    end

    describe "GET #new" do

      before do
        get :new
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:formtemplate)).to be_new_record }

    end

    describe "post #create" do

      before do
        post :create, params: { form_template: params }
      end

      context 'save success' do
        let(:params) { attributes_for(:form_template, user: admin) }
        it { expect(FormTemplate.count).to eq(1) }
      end

      context 'save fails' do
        let(:params) { attributes_for(:form_template, :invalid, user: admin) }
        it { expect(FormTemplate.count).to eq(0) }
        it { expect(response).to render_template(:new) }
      end

    end

    describe "GET #edit" do
      let(:formtemplate) { create(:form_template) }
      before do
        get :edit, params: { id: formtemplate.id }
      end

      it { expect(assigns(:formtemplate)).to eq(formtemplate) }
      it { expect(response).to have_http_status(:success) }

    end

    describe "post #update" do
      let(:formtemplate) { create(:form_template) }

      before do
        post :update, params: { id: formtemplate.id, form_template: params }
      end

      let(:params) { attributes_for(:form_template, title: "New Title!") }
      it { expect(assigns(:formtemplate)).to eq(formtemplate) }
      it { expect(response).to have_http_status(:success) }
      it { expect(assigns(:formtemplate).title).to eq("New Title!") }
    end

    describe "GET #destroy" do
      let(:formtemplates) { create_list(:form_template, 3) }

      before do
        get :destroy, params: { id: formtemplates[0] }
      end

      it { expect(FormTemplate.count).to eq(2) }
      it { expect(response).to redirect_to formtemplates_path }

    end
  end

  context 'user signed in' do
  end


end
