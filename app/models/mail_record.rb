class MailRecord < Record
  validates :name, presence: true
  validates :priority, presence: true
  validates :content, presence: true

  def self.requires_priority?
    true
  end
end
