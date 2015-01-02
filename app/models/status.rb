class Status < ActiveRecord::Base
  belongs_to :user
  # Desc order of created at
  default_scope->{order(created_at: :desc)}  
  validates :user_id, presence: true
  validates :content, presence: true, length: {minimum: 1}
  mount_uploader :picture, PictureUploader
  validate :picture_size  


  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Should be less than 5MB")
    end
  end
end
