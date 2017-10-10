class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :wikis
  before_save { self.role ||= 'standard' }
  
  enum role: [
    :standard,
    :premium,
    :admin
  ]
  
  def set_admin 
    self.admin!
  end

  def set_standard
    self.standard!
  end
  
  def set_premium
    self.premium!
  end
  
  def owns?(arg)
    self.id == arg.user_id
  end

end
