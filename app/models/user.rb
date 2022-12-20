class User < ApplicationRecord
  devise :database_authenticatable, 
         :recoverable, :rememberable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
  
  validates :email, presence: true
  validates :email, uniqueness: true
  #enum  role: [:user,:admin,:superadmin]  
 
  #after_initialize :set_default_role, :if=>:new_record?
 
  has_many :sentences
  has_many :clips

  #def set_default_role
   # self.role ||= :user
  #end
  
 
  
end
