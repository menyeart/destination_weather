class User < ApplicationRecord
  before_create :set_api_key
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  encrypts :api_key, deterministic: true, downcase: true

  has_secure_password


private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end