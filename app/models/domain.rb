class Domain < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :name, uniqueness: true

  before_save { name.downcase! }
end
