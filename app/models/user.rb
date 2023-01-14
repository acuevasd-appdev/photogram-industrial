class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :own_photos, class_name: "Photo", foreign_key: "owner_id", counter_cache: true
  has_many :comments, foreign_key: "author_id", counter_cache: true
  has_many :followers, foreign_key: "recipient_id", counter_cache: true
  has_many :following, foreign_key: "sender_id", counter_cache: true
  has_many :likes, foreign_key: "fan_id"
end
