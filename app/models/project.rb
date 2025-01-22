class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
  has_many_attached :documents
  validates_presence_of :name, :state, :astimated_cost
  enum :state, %i(pending started finished)
  validates_uniqueness_of :name
end
