class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :service_bills
  has_many :payments_bills
  has_many :cloths_bills
  has_many :eb_bills
  has_many :courier_bills

  def admin?
  	false
  end
end
