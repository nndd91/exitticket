class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_question, only: [:edit, :destroy, :update]

  def edit
  end

  def update
    @formtemplate = FormTemplate.find(params[:formtemplate_id])
    @question.update(question_params)
    @question.save
    redirect_to formtemplate_path(id: @formtemplate)
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
    @formtemplate = FormTemplate.find(params[:formtemplate_id])
    @question.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:label, :qns_type)
  end

  def authenticate_admin
    if !current_user.is_admin
      flash[:notice] = "Only admin can view this page!"
      redirect_to root_path
    end
  end
end
