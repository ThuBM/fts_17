class TestsController < ApplicationController
  before_action :check_admin_user, only: [:index, :create, :show, :update]

  def index
    @test = Test.new
    @tests = current_user.tests
  end

  def create
    test = Test.new test_params
    if test.save
      flash[:success] = "You created a test!"
      redirect_to tests_path
    else
      flash[:danger] = "Not complete creating test!"
      redirect_to tests_path
    end
  end

  def show
    @test = Test.find params[:id]
    if @test.ready?
      @count_down_time = @test.lesson.time * 60
    else
      @count_down_time = @test.lesson.time * 60 - (Time.zone.now - @test.start_time).to_i
    end
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def update
    @test = Test.find params[:id]
    if @test.ready?
      @test.start_time = Time.zone.now
      @test.status = params[:status]
      @test.current_session_id = session[:session_id]
      @test.save
    elsif @test.update_attributes test_params
      flash[:info] = "Update answer sheet!"
      @count_down_time = @test.lesson.time * 60 - (Time.zone.now - @test.start_time).to_i
      if @test.completed?
        @test.auto_check
        UserMailer.tests_completed(@test, current_user).deliver_now
      end
      @test.save
      render :show
    else
      flash[:danger] = "Can't update answer sheet!"
      redirect_to tests_path
    end
  end

  private
  def test_params
    params.require(:test).permit :id, :lesson_id, :user_id, :status,
      answers_attributes: [:id, :option_id, :content]
  end

  def check_admin_user
    if current_user.role == "admin"
      redirect_to admin_tests_path
    end
  end
end