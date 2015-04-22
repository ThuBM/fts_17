class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :test
  belongs_to :option

  scope :correct_answer, -> {where(correct: true)}
end