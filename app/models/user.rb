class User < ApplicationRecord
  
  devise :database_authenticatable, 
         :recoverable, :rememberable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

         
  has_many :user_sentences
  has_many :sentences, through: :user_sentences
  has_many :records, :class_name => "Clip"
  has_many :votes
  has_many :clips, through: :votes


  validates :email, presence: true
  validates :email, uniqueness: true
  validates_confirmation_of :password
  validates_format_of :email, with: Devise.email_regexp, allow_blank: true, if: :will_save_change_to_email?
  
  enum  role: [:user,:admin,:superadmin]  
  enum  sex: { M: 0, F: 1} 


  after_initialize :set_default_role, :if=>:new_record?


 
  
  def set_default_role
    self.role ||= :user
  end
  


end
