# Controller for Questions
class QuestionsController < ApplicationController
  before_action :require_user, only: %i[show]
  before_action :require_admin, only: %i[new index edit update destroy]

  def index
    @page_title = "Quiz Questions"
    if params[:subject_id].blank?
      @questions = Question.all.paginate(page: params[:page], per_page: 5)
    else
      @questions = Question.by_subject(params[:subject_id]).paginate(page: params[:page], per_page: 5)
    end
  end

  def new
    @page_title = "New Question"
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if !@question.save
      flash[:danger] = 'Your changes could not be saved!!'
      render 'new'
    else
      flash[:success] = 'Question successfully created'
      redirect_to question_path(@question.id)
    end
  end

  def edit
    @page_title = "Edit Question"
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update_attributes(question_params)
      flash[:success] = 'Question successfully updated'
      redirect_to question_path(@question.id)
    else
      render 'edit'
    end
  end

  def show
    @page_title = "Show Updated Question"

    if current_user.admin?
      @question = Question.find(params[:id])
    end
    render 'show'
  end

  private

  def question_params
    params.require(:question).permit(:subject_id, :question, :choice1,
                                     :choice2, :choice3, :answer)
  end
end

