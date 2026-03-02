class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :articles, dependent: :destroy
  # Validation déjà gérée par Devise pour l'email, mais on peut ajouter :
  validates :email, presence: true, uniqueness: true
end