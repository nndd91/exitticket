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
  end
end
