class Record < ActiveRecord::Base
  extend InheritenceBaseNaming

  belongs_to :domain, counter_cache: true
  has_one :user, through: :domain

  validates :domain, presence: true

  default_scope order: [:name, :priority]

  TYPE_CLASS = {
    "A" => "AddressRecord",
    "MX" => "MailRecord",
  }.freeze
  CLASS_TYPE = TYPE_CLASS.invert.freeze
  TYPES = TYPE_CLASS.keys.freeze

  def self.[] type
    TYPE_CLASS[type].constantize
  end

  def humanized_type
    CLASS_TYPE[self.class.name]
  end

  def humanized_name
    name.presence || domain.name
  end

  def self.requires_priority?
    false
  end

  delegate :requires_priority?, to: :class
end
