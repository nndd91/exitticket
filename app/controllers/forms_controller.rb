class FormsController < ApplicationController
  before_action :setup_form, only: [:show, :attempt, :attempting]
  before_action :authenticate_user!

  def new
    @form = current_user.forms.build
  end

  def show
    @questions = @form.questions
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
  end

  def update
  end

  def edit
  end

  def index
    @forms = Form.all
  end

  def attempt
  end

  def attempting
    #array = [:q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10]
    @answers_array = params[:form][:answers_array].split('|')
    @form.questions.each_with_index do |question, index|
      @answer = question.answers.build(content: @answers_array[index], form: @form)
      @answer.user = current_user
      @answer.save
    end

    redirect_to forms_path
  end

  private

  def setup_form
    @form = Form.find(params[:id])
  end

  def attempting_params
  end

  def form_params
    params.require(:form).permit(:form_template, :form_date, :title, :description)
    params[:form][:form_template] = FormTemplate.find(params[:form][:form_template])
  end
end
