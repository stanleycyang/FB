class Status < ActiveRecord::Base
  belongs_to :user
  # Desc order of created at
  default_scope->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: {minimum: 1}
end
