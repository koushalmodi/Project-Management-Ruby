class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  has_one :profile, dependent: :destroy
  has_many :projects, dependent: :destroy
  # delegate :role, to: :profile, allow_nil: true

  def developer?
    profile.developer?
  end


  def lead?
    profile.lead?
  end

  def manager?
    profile.manager?
  end
end
