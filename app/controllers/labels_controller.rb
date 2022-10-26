class LabelsController < ApplicationController
  before_action :set_label, only: %i[ edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]
  skip_before_action :logout_required

  def index
    @labels = Label.all
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, notice: Label.human_attribute_name(:label_created)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: Label.human_attribute_name(:label_updated)
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: Label.human_attribute_name(:label_destroyed)
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
