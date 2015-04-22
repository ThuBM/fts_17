class Lesson < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, 
    reject_if: :reject_questions, allow_destroy: true
  validates :name, presence: true

  private
  def reject_questions(attributes)
    attributes[:content].blank?
  end
end