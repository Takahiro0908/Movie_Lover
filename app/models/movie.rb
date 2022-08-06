class Movie < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tags, dependent: :destroy

  #バリデーションの設定
  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
  favorites.exists?(user_id: user.id)
  end

end
