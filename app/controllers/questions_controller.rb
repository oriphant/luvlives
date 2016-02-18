class QuestionsController < ApplicationController
  def index
  	@questions = Question.all
    authorize @questions
  
    if params[:query].present?
      @questionsearchs = Question.search(params[:query])
    else
      @questionsearchs = Question.all
    end

  end

  def show
  	@question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.new
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

  def search
    if params[:search].present?
      @questions = Question.search(params[:search])
      # @questions = Question.search(params[:search], index_name: [Model1.index.name, Model2.index.name, Model3.index.name])
      # @questions = Question.search(params[:search], index_name: [Model1.searchkick_index.name, Model2.searchkick_index.name, Model3.searchkick_index.name], other_options)
    else 
      @questions = Question.all
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, :public, :genderlimit, :agelimit, :anonymous, :views, :shared)
  end

end #Class End
