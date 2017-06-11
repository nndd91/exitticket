class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_question, only: [:edit, :destroy, :update, :move_up, :move_down]

  def edit
  end

  def move_up
    @formtemplate = FormTemplate.find(params[:formtemplate_id])

    if @question.qns_no > 1
      final_number = @question.qns_no - 1

      # Update question no of the one before
      @prev_question = @formtemplate.questions.find_by(qns_no: final_number)
      @prev_question.qns_no += 1
      @prev_question.save

      # Update question number
      @question.qns_no -= 1
      @question.save
    end

    respond_to do |format|
      format.js
    end
  end

  def move_down
    @formtemplate = FormTemplate.find(params[:formtemplate_id])

    if @question.qns_no < @formtemplate.questions.order('qns_no ASC').last.qns_no
      final_number = @question.qns_no + 1

      # Update question no of the one after
      @next_question = @formtemplate.questions.find_by(qns_no: final_number)
      @next_question.qns_no -= 1
      @next_question.save

      # Update own question no.
      @question.qns_no += 1
      @question.save
    end
    respond_to do |format|
      format.js
    end
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

    if @formtemplate.questions.count > 0
      last_question_no = @formtemplate.questions.order("qns_no ASC").last.qns_no
      @question.qns_no = last_question_no + 1
    else
      @question.qns_no = 1
    end

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

    # Need to set the question number of the other questions.
    @questions = @formtemplate.questions.order('qns_no ASC')
    @questions.each_with_index do |question, index|
      question.qns_no = index + 1
      question.save
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:label, :qns_type, :required, :qns_no)
  end

  def authenticate_admin
    if !current_user.is_admin
      flash[:notice] = "Only admin can view this page!"
      redirect_to root_path
    end
  end
end
