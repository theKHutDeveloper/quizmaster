class QuizzesController < ApplicationController
	before_action :require_user, only: %i[index, new, show]

	def index
		@questions = Quiz.questions(params[:subject_id]).paginate(:page => params[:page], :per_page => 1)
		@quiz_size = Quiz.size(params[:subject_id])

		@questions.each do |question|
			@choices = question.convert
		end

		p "Quiz = #{@quiz}"

	end

	def new
		@quiz = Quiz.new

		@questions = Quiz.questions(params[:subject_id]).paginate(:page => params[:page], :per_page => 1)
		@quiz_size = Quiz.size(params[:subject_id])

		@questions.each do |question|
			@choices = question.convert
		end

	end

	def create
		@quiz = Quiz.create(quiz_params)
		#@quiz = Quiz.new({ user_id: current_user.id, subject_id: params[:subject_id], answered_question: {} })
		if !@quiz.save
      flash[:danger] = 'Your changes could not be saved!!'

		else
			flash[:success] = 'Your changes have been updated'
		end
	end

	def show; end

private

	def quiz_params
		params.require(:quiz).permit(:user_id, :subject_id, :answered_question)
	end
end










	# def choice
	# 	params.permit(:list)
	# end

# p params
		# subject = params[:subject_id]
		# # subject = Question.find(params[:subject_id]) 
		# p "subject is #{subject}"

		# # @questions = Quiz.questions(subject[:subject_id]).paginate(:page => params[:page], :per_page => 1)
		# # @quiz_length = Quiz.size(1)
		# # @choices = Quiz.choices(1)
		# # @counter = params[:page].to_i - 1
		# #how to reference radio box?
		# p @quiz