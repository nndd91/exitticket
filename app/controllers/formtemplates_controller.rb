class FormtemplatesController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_formtemplate, only: [:show, :edit, :update, :destroy]

  def index
    @formtemplates = FormTemplate.all.order(:id)
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
      redirect_to edit_formtemplate_path(@formtemplate)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @formtemplate.update(formtemplate_params)
    @formtemplate.save
    redirect_to edit_formtemplate_path(@formtemplate)
  end

  def destroy
    @formtemplate.destroy
    redirect_to formtemplates_path
  end

  private

  def set_formtemplate
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
