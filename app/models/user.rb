class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :name
  
  # validates_presence_of :name
  validates :auth_token, uniqueness: true

  def info
    "#{email} - #{created_at} - Token: #{Devise.friendly_token}"
  end
end