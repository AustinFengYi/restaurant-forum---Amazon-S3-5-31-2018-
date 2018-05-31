class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image , PhotoUploader

  belongs_to :category , optional: true
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites,source: :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

def self.search(query)
  where("name like ?" , "%#{query}%")
end

def prev
  Restaurant.where("id < ?", id).last
end

def next
  Restaurant.where("id > ?", id).first
end

def is_favorited?(user)
  self.favorited_users.include?(user)
end

def is_liked?(user)
  self.liked_users.include?(user)
end

#def count_favorites
    #self.favorites_count = self.favorites.size
    #self.save
  #end


end
