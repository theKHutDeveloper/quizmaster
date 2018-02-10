# Controller for Subject
class SubjectsController < ApplicationController
  before_action :require_admin, only: %i[new create edit update destroy]

  def index
    @page_title = "Subject List"
    @subjects = Subject.all
  end

  def new
    @page_title = "New Subject"
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if !@subject.save
      flash[:danger] = 'Your changes could not be saved!!'
      render 'new'
    else
      flash[:success] = 'Subject successfully created'
      redirect_to subject_path(@subject.id)
    end
  end

  def show
    @page_title = "Show Subject"
    @subject = Subject.find(params[:id])
  end

  def edit
    @page_title = "Edit Subject"
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update_attributes(subject_params)
      flash[:success] = 'Subject successfully updated'
      redirect_to subject_path(@subject.id)
    else
      render 'edit'
    end
  end

  def destroy; end

  private

  def subject_params
    params.require(:subject).permit(:id, :subject, :difficulty, :points)
  end
end
