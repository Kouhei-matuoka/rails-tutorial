class QuestionStepsController < ApplicationController
  include Wicked::Wizard
  steps :first, :second, :third, :fourth
  
  def show
    @question = current_question
    render_wizard
  end
  
  def update
    @question = current_question
    @question.update_attributes(question_params)
    case step
    when :fourth
      return redirect_to question_path(@question.id)
    end
    puts question_params
    puts @question.first_answer
    puts @question.second_answer
    puts @question.third_answer
    puts @question.fourth_answer
    render_wizard @question
  end
  
  private
  
  def question_params
    params.require(:question).permit(:first_answer, :second_answer, :third_answer, :fourth_answer)
  end
  
  def finish_wizard_path
    questions_path(current_question)
  end
  
  def current_question
    return Question.find(session[:question_id]) if session[:question_id].present?
    q = Question.create!
    session[:question_id] = q.id
    q
  end
end
