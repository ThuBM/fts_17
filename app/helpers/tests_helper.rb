module TestsHelper
  include UsersHelper

  def get_word_of_link test
    if test.ready?
      user_admin? ? "Not start" : "Start"
    elsif test.testing?
      user_admin? ? "Doing" : "Continue"
    elsif test.completed?
      user_admin? ? "Check" : "View"
    end 
  end

  def get_option_style answer, option, test
    if option.correct && test.completed?
      answer.correct ? "color:blue" : "color:red"
    else
      ""
    end  	
  end

  def current_session_doing_test? test
    test.current_session_id == session[:session_id]
  end
end