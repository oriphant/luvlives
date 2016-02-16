class AnswersController < ApplicationController

  def new
 		@question = Question.find(params[:question_id])
 		@answers = @question.answers
 		@answer = Answer.new
    authorize @question
  end

 	def create
 		@question = Question.find(params[:question_id])
 		@answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    authorize @question
    if @answer.save
      flash[:notice] = "Your answer was saved."
      redirect_to questions_path
    else
      flash[:error] = "There was an error saving your answer. Please try again."
      render :new
    end
 	end

  def edit
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    if @answer.update_attributes(answer_params)
      flash[:notice] = "Your Answer Was Successfully Updated."
      redirect_to questions_path
    else
      flash[:error] = "There was an error updating your answer. Please try again."
      render :edit
    end
  end

  def vote

    @answer = Answer.find(params[:answer_id])

    @vote = @answer.votes.build(user: current_user, vote: params[:vote])

    if @vote.save
      flash[:notice] = "You voted."
      redirect_to :back
    else
      flash[:notice] = "Something wrong happened."
      redirect_to :back
    end
    # Vote.create(voteable: @answer, user: current_user, vote: params[:vote])

  end

 	private

 	def answer_params
 	  params.require(:answer).permit(:body) #Do I need others like views, helpful, sharedcount
 	end

end
