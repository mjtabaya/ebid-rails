class Auction < ApplicationRecord
  has_many :bid_entries, :dependent => :destroy
  belongs_to :user, :dependent => :destroy
  default_scope -> { order(date_auctioned: :desc) }
  validates :user_id, :status, presence: true
  enum status: %i[pending ongoing completed]
  validates :status, inclusion: { in: status.keys }

  def self.status_options
    status.map { |k, _v| [k.humanize.capitalize, k] }
  end
end
