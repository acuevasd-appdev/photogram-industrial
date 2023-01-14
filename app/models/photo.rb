class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :comments, counter_cache: true
  has_many :likes, counter_cache: true
end
