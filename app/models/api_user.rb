require 'securerandom'

class ApiUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_api_key

  #
  ## Generate API Key
  def set_api_key
    return if api_key.present?
    self.api_key = generate_api_key
  end

  def generate_api_key
    SecureRandom.uuid.gsub(/\-/, '')
  end

end
