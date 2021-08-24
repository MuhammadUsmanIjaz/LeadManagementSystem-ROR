class User < ApplicationRecord
  validates :email, :name, presence: true

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :leads
  has_many :user_phases
  has_many :phases, through: :user_phases
end
