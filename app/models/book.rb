class Book < ApplicationRecord
    belongs_to :user

    has_many :book_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true, length: {maximum: 200}

    def favorited_by?(a)
        favorites.where(user_id: a.id).exists?
    end
end
