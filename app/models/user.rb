class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :domains, dependent: :destroy
  has_many :records, through: :domains
end
