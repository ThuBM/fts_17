class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100"}, 
    default_url: ":styles/default.png"
  
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  has_many :tests
  
  scope :without_user, ->user {where.not id: user}
  
  protected 
  def password_required? 
    false 
  end
end
