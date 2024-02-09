class Account < ApplicationRecord
  has_many :activity_participants
  has_many :activities, through: :activity_participants
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
