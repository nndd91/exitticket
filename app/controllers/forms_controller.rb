class FormsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin, except: [:index, :attempt, :attempting]
  before_action :setup_form, only: [:show, :attempt, :attempting, :status, :results]
  before_action :setup_questions, only: [:show, :results]

  def new
    @form = current_user.forms.build
  end

  def show
  end

  def create
    params[:form][:form_template] = FormTemplate.find(params[:form][:form_template])
    @form = current_user.forms.build(form_params)
    @form.form_template = params[:form][:form_template]
    if @form.save
      redirect_to form_path(@form)
    else
      render :new
    end
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def index
    @forms = Form.all.order('created_at DESC')
  end

  def attempt
  end

  def attempting
    #array = [:q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10]

    @form.questions.each_with_index do |question, index|
      params_symbol = ('q'+(index+1).to_s).to_sym
      @answer = question.answers.build(content: params[:form][params_symbol], form: @form)
      @answer.user = current_user
      @answer.save
    end

    @log = @form.logs.build(user: current_user)
    @log.save

    redirect_to forms_path
  end

  def status
    @logs = @form.logs
    @users = User.all
    respond_to do |format|
      format.js
    end
  end

  def results
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
    params.require(:form).permit(:form_template, :form_date, :title, :description)
  end

  def authenticate_admin
    if !current_user.is_admin
      flash[:notice] = "Only admin can view this page!"
      redirect_to root_path
    end
  end
end
