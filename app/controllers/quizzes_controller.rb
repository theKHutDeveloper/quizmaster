class QuizzesController < ApplicationController
	
	before_action :require_user, only: %i[index, new, show]

	def index
		@page_title = "Quiz History"
		@quizzes = Quiz.all_quizzes(current_user.id).paginate(page: params[:page], per_page: 5)
	end

	def new
		@quiz = Quiz.new
		@user_id = params[:user_id]
		@subject_id = params[:subject_id]

		@page_title = "#{Subject.find(@subject_id).subject} Quiz"
		@questions = Quiz.questions(params[:subject_id])
		
		@choices = []
		@question_ids = []

		@questions.each do |question|
			@choices << question.convert
			@question_ids << question.id
		end
	end

	def create
		@quiz = Quiz.new(quiz_params)
		results =  Quiz.result(quiz_params[:subject_id], quiz_params[:answered_question])
		@quiz.score = results

		if !@quiz.save
      flash[:danger] = 'Your changes could not be saved!!'
      redirect_to new_quiz_path(user_id: quiz_params[:user_id], subject_id: quiz_params[:subject_id])
		else
			redirect_to quiz_path(id: @quiz.id, user_id: @quiz.user_id, subject_id: @quiz.subject_id)
		end
	end

	def show
		@page_title = "Quiz Results"
		@quiz = Quiz.review(params[:id], params[:user_id], params[:subject_id])
		@questions = Quiz.reveal_questions(@quiz.answered_question)
		@answers = Quiz.reveal_user_answers(@quiz.answered_question)
		@correct_list = Quiz.reveal_correct_answers(@quiz.subject_id, @quiz.answered_question)
	end

private

	def quiz_params
		params.require(:quiz).permit(:user_id, :subject_id, :answered_question)
	end

	def show_params
		params.require(:quiz).permit(:id, :user_id, :subject_id)
	end
end
