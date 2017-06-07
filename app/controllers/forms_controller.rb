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
end
