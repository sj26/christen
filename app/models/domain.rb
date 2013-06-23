class Domain < ActiveRecord::Base
  belongs_to :user
  has_many :records, dependent: :destroy

  validates :user, presence: true
  validates :name, uniqueness: true

  before_save { name.downcase! }

  def to_s
    name
  end

  def to_param
    name
  end
end
