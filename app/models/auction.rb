class Auction < ApplicationRecord
  has_many :auction_entries, :dependent => :destroy
  accepts_nested_attributes_for :auction_entries
  belongs_to :user, :dependent => :destroy
  default_scope -> { order(date_auctioned: :desc) }
  validates :user_id, :status, presence: true
  enum status: %i[pending ongoing completed]
  validates :status, inclusion: { in: statuses.keys }

  def self.status_options
    statuses.map { |k, _v| [k.humanize.capitalize, k] }
  end
end
