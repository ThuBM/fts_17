class Admin::LessonsController < ApplicationController
  def index
    
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      flash[:info] = "Created new lesson: #{@lesson.name}"
      redirect_to admin_lessons_path
    else
      render :new
    end
  end

  def edit
    @lesson = Lesson.find params[:id]
  end

  def update
    @lesson = Lesson.find params[:id]
    if @lesson.update(lesson_params) && @lesson.save
      flash[:info] = "Updated lesson!"
      redirect_to admin_lessons_path
    else
      render :edit
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :name, :time,
      questions_attributes: [:content, :id, 
        options_attributes: [:content, :correct, :_destroy, :id]]
  end
end