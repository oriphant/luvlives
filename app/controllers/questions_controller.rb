class QuestionsController < ApplicationController
  def index
  	@questions = Question.all
    authorize @questions
  end

  def show
  	@question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.build
  end

  def new
    @question=Question.new
    authorize @question
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    authorize @question
     if @question.save
      @question.labels = Label.update_labels(params[:question][:labels])
      flash[:notice] = "Question was saved successfully."
      redirect_to @question
     else
      flash[:error] = "There was an error saving the question. Please try again."
       render :new
     end
  end

  def edit
    @question = Question.find(params[:id])
    authorize @question
  end

  def update
    @question = Question.find(params[:id])
    authorize @question
    if @question.update_attributes(question_params)
      @question.labels = Label.update_labels(params[:question][:labels])
      flash[:notice] = "Your Question Was Successfully Updated."
     redirect_to @question
    else
     flash[:error] = "There was an error updating your question. Please try again."
     render :edit
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, :public, :genderlimit, :agelimit, :anonymous, :views, :shared)
  end

end #Class End
