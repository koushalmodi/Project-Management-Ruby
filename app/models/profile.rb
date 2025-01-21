class Profile < ApplicationRecord
  belongs_to :user
  enum :role, %i(lead manager developer)
  has_one_attached :profile_image
  validates_presence_of :first_name, :last_name, :prefix, :role, :profile_image
end
