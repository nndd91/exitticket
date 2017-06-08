class FormtemplatesController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_formtemplates, only: [:show, :edit, :update, :destroy]

  def index
    @formtemplates = FormTemplate.all
  end

  def show
    @questions = @formtemplate.questions
  end

  def new
    @formtemplate = FormTemplate.new
  end

  def create
    @formtemplate = FormTemplate.new(formtemplate_params)
    @formtemplate.user = current_user
    if @formtemplate.save
      redirect_to formtemplate_path(@formtemplate)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_formtemplates
    @formtemplate = FormTemplate.find(params[:id])
  end

  def authenticate_admin
    if !current_user.is_admin
      flash[:notice] = "Only admin can view this page!"
      redirect_to root_path
    end
  end

  def formtemplate_params
    params.require(:form_template).permit(:title, :description)
  end
end
