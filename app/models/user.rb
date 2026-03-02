class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :photos, dependent: :destroy

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true
end