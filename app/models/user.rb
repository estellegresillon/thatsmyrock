class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :user_albums
  has_many :albums, through: :user_albums
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
