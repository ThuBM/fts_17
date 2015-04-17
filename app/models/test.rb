class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true

  before_create :init_answers

  scope :warning_first, -> {where("created_at < ? and status = 'Ready'", Time.zone.now - 5.days)}

  def completed?
    self.status == "Completed"
  end

  def submitted?
    self.status == "Submitted"
  end

  def ready?
    self.status == "Ready"
  end

  def testing?
    !self.ready? && !self.completed?
  end

  def auto_check
    self.answers.each do |answer|
      answer.correct = answer.option && answer.option.correct
    end
  end

  private
  def init_answers
    self.lesson.questions.sample(20).each do |question|
      self.answers.build(question: question)
    end
  end
end