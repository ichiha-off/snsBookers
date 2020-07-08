class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_commetns, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_relationship, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :active_relationship, source: :follower
  has_many :follower_user, through: :passive_relationships, source: :following
  
  attachment :profile_image
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def follow(id)
    active_relationship.create(follower_id: id)
  end

  def unfollow(id)
    unfollow = active_relationship.find_by(follower_id: id)
    unfollow.destroy
  end

  def following?(id)
    following_user.include?(id)
  end

end
