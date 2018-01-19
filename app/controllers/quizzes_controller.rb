class QuizzesController < ApplicationController
	
	before_action :require_user, only: %i[index, new, show]

	def index
		@quizzes = Quiz.all_quizzes(current_user.id)
	end

	def new
		@quiz = Quiz.new
		@user_id = params[:user_id]
		@subject_id = params[:subject_id]

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
			flash[:success] = 'Your changes have been updated'
			render 'show'
		end
	end

	def show
		@quiz = Quiz.review(params[:id], params[:user_id], params[:subject_id])
		#get an array to hold the answers given by user
		#get the questions from the question id in array
		#if answer is correct have a tick image placed next to answer
		#if answer is incorrect have a cross image placed next to answer
	end

private

	def quiz_params
		params.require(:quiz).permit(:user_id, :subject_id, :answered_question)
	end

	def show_params
		params.require(:quiz).permit(:id, :user_id, :subject_id)
	end
end
