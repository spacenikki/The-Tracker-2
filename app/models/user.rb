class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :ffs, :dependent=>:destroy
  has_many :cars, :dependent=>:destroy
  has_many :hotels, :dependent=>:destroy
end
