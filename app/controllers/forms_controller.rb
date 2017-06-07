class FormsController < ApplicationController
  before_action :setup_form, only: [:show, :attempt, :attempting]
  before_action :authenticate_user!

  def new
  end

  def show
    @questions = @form.questions
  end

  def create
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

    @form.questions.each_with_index do |question, index|
      params_symbol = ('q'+(index+1).to_s).to_sym
      @answer = question.answers.build(content: params[:form][params_symbol], form: @form)
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
end
