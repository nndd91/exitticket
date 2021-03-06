class FormsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:index, :attempt, :attempting]
  before_action :setup_form, only: [:show, :attempt, :attempting, :status, :results, :destroy, :edit, :update]
  before_action :setup_questions, only: [:show, :results]

  def new
    @form = current_user.forms.build
  end

  def show
  end

  def create
    @form = current_user.forms.build(form_params)
    if @form.save
      redirect_to form_path(@form)
    else
      render :new
    end
  end

  def destroy
    @form.destroy
    redirect_to forms_path
  end

  def update
    @form.update(form_params)
    @form.save
    redirect_to form_path(@form)
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def index
    @forms = Form.all.order('created_at DESC')
  end

  def attempt
  end

  def attempting
    #array = [:q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10]
    save_success = true
    @invalid_fields = []
    @values_cache = []
    @form.questions.order('qns_no ASC').each_with_index do |question, index|
      params_symbol = ('q'+(index+1).to_s).to_sym
      @answer = question.answers.build(content: params[:form][params_symbol], form: @form)
      @answer.user = current_user
      @values_cache << @answer.content
      if (question.required && (@answer.content.nil? || @answer.content.empty?))
        flash[:notice] = "Please fill in required fields!"
        save_success = false
        @invalid_fields << question.id
      else
        @answer.save
      end
    end

    if save_success
      @log = @form.logs.build(user: current_user)
      @log.save

      redirect_to forms_path
    else
      @answers = Answer.where(form: @form, question: @form.questions, user: current_user)
      @answers.each do |answer|
        answer.destroy
      end
      redirect_to attempt_form_path(values_cache: @values_cache, invalid_fields: @invalid_fields)
    end
  end

  def status
    @logs = @form.logs
    @users = User.all
    respond_to do |format|
      format.js
    end
  end

  def results
    respond_to do |format|
      format.js
    end
  end

  private

  def setup_form
    @form = Form.find(params[:id])
  end

  def setup_questions
    @questions = @form.questions
  end

  def attempting_params
  end

  def form_params
    params.require(:form).permit(:form_template_id, :form_date, :title, :description)
  end

  def authenticate_admin
    if !current_user.is_admin
      flash[:notice] = "Only admin can view this page!"
      redirect_to root_path
    end
  end
end
