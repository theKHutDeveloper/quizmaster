class QuizzesController < ApplicationController
	
	before_action :require_user, only: %i[index, new, show]

	def index
		@questions = Quiz.questions(params[:subject_id])
		@quiz_size = Quiz.size(params[:subject_id])

		@questions.each do |question|
			@choices = question.convert
		end
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

		if !@quiz.save
      flash[:danger] = 'Your changes could not be saved!!'
		else
			results =  Quiz.result(quiz_params[:subject_id], quiz_params[:answered_question])
			flash[:success] = 'Your changes have been updated'
		end

		render 'show'
	end

	def show

	end

private

	def quiz_params
		params.require(:quiz).permit(:user_id, :subject_id, :answered_question)
	end
end
