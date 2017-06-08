class QuestionsController < ApplicationController
  def list
    @formtemplate = FormTemplate.find(params[:id])
    @questions = @formtemplate.questions
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @formtemplate = FormTemplate.find(params[:formtemplate_id])
    @question = @formtemplate.questions.build(question_params)
    if @question.save
      respond_to do |format|
        format.js
      end
    else
    end
  end

  def destroy
  end

  private

  def question_params
    params.require(:question).permit(:label, :qns_type)
  end
end
