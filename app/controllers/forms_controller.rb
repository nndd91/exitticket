class FormsController < ApplicationController
  def new
  end

  def show
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
    @form = Form.find(params[:id])
  end

  def attempting
    @form = Form.find(params[:id])

    array = [:q1, :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10]
    @form.questions.each_with_index do |question, index|
      @answer = question.answers.build(content: params[:form][array[index]], form: @form)
      @answer.user = current_user
      @answer.save
    end

    redirect_to forms_path
  end

  private

  def attempting_params
  end
end
