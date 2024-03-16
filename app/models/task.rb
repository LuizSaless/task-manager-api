class Task < ApplicationRecord
  belongs_to :user

  validates :user_id, :title, presence: true
  # validate_presence_of :title, :user_id

end
